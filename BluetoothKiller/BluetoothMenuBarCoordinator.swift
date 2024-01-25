//
//  DataViewModel.swift
//  KillBT
//
//  Created by Will Crane on 1/17/24.
//

import Foundation
import SwiftUI
import IOBluetooth
import NotificationCenter

@Observable class BluetoothCoordinator {
    var deviceConnections: [String: Bool]
    private var sleeping = false
    private var connectedDevices: [IOBluetoothDevice] {
        IOBluetoothDevice.devices.filter({ deviceConnections[$0.name] ?? false })
    }
//    var launchConfig: LoginLaunchInterface

    init() {
        deviceConnections = Dictionary(uniqueKeysWithValues: IOBluetoothDevice.devices.map({ ($0.name, $0.isConnected()) }))
        IOBluetoothDevice.register(forConnectNotifications: self, selector: #selector(connect))
        IOBluetoothDevice.devices.forEach({ $0.register(forDisconnectNotification: self, selector: #selector(disconnect)) })
 
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(wake), name: NSWorkspace.screensDidWakeNotification, object: nil)
        NSWorkspace.shared.notificationCenter.addObserver(self, selector: #selector(sleep), name: NSWorkspace.screensDidSleepNotification, object: nil)
//        launchConfig = LoginLaunchInterface()
    }
    
    @objc private func connect(notification: IOBluetoothUserNotification, device: IOBluetoothDevice) {
        deviceConnections[device.name] = true
    }

    @objc private func disconnect(notification: IOBluetoothUserNotification, device: IOBluetoothDevice) {
        if !sleeping {
            deviceConnections[device.name] = false
        }
    }

    @objc private func wake(notification: NSNotification) {
        sleeping = false
        connectedDevices.forEach({ $0.openConnection() })
    }

    @objc private func sleep(notification: NSNotification) {
        sleeping = true
        connectedDevices.forEach({ $0.closeConnection() })
    }
}
