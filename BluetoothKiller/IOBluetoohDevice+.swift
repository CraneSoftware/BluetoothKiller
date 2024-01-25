//
//  IOBluetoohDevice+.swift
//  BluetoothKiller
//
//  Created by Kevin McKenney on 1/20/24.
//

import Foundation
import SwiftUI
import IOBluetooth

extension IOBluetoothDevice {
    static var devices: [IOBluetoothDevice] {
        Self.pairedDevices().compactMap {
            if let device = $0 as? IOBluetoothDevice {
                return device
            } else {
                return nil
            }
        }
    }
}
