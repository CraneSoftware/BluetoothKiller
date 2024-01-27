//
//  BluetoothMenuBarCoordinator.swift
//  BluetoothKiller
//
//  Created by Will Crane on 1/17/24.
//

import Foundation
import SwiftUI
import IOBluetooth
import NotificationCenter

@Observable class BluetoothMenuBarCoordinator {
    var deviceConnections: [String: Bool]
    private var sleeping = false
//    var launchConfig: LoginLaunchInterface

    init() {
        deviceConnections = Dictionary(IOBluetoothDevice.devices.map({ ($0.name, $0.isConnected()) }), uniquingKeysWith: { $1 })
        IOBluetoothDevice.register(forConnectNotifications: self, selector: #selector(onConnection(notification:from:)))
        IOBluetoothDevice.devices.forEach({ $0.register(forDisconnectNotification: self, selector: #selector(onConnection(notification:from:))) })
 
        [NSWorkspace.screensDidWakeNotification, NSWorkspace.screensDidSleepNotification].forEach { name in
            NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(onScreen(notification:)), name: name, object: nil)
        }
//        launchConfig = LoginLaunchInterface()
    }
    
    @objc private func onConnection(notification: IOBluetoothUserNotification, from device: IOBluetoothDevice) {
        if !sleeping { deviceConnections[device.name] = notification.className == "IOBluetoothConcreteUserNotification" }
    }

    @objc private func onScreen(notification: NSNotification) {
        sleeping = notification.name == NSWorkspace.screensDidSleepNotification
        IOBluetoothDevice.devices.filter({ deviceConnections[$0.name] == true }).forEach { device in
            sleeping ? device.closeConnection() : device.openConnection()
        }
    }
}
