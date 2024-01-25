//
//  KillBTApp.swift
//  KillBT
//
//  Created by Will Crane on 1/15/24.
//

import SwiftUI

@main

struct BluetoothKillerApp: App {
    @State var coordinator = BluetoothCoordinator()
    
    var body: some Scene {
        MenuBarExtra("UtilityApp", systemImage:"playstation.logo") {
            BluetoothMenuBarView(coordinator: coordinator)
        }
        .menuBarExtraStyle(.window)
    }
}

