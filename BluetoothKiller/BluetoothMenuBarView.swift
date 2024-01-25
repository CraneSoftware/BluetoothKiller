//
//  ContentView.swift
//  BluetoothKiller
//
//  Created by Will Crane on 1/18/24.
//

import SwiftUI

struct BluetoothMenuBarView: View {
    @State var coordinator: BluetoothCoordinator

    var body: some View {
        ScrollView{
            Divider()
            Text("Bluetooth Killer")
            
            Spacer()
            
            List{
                ForEach(coordinator.deviceConnections.map({ $0 }), id: \.key) { name, isConnected in
                    Text("device: \(name) connected: \(isConnected.description)")
                }
            }
            
            Spacer()
//                Text("Login at Launch: ".appending("\(vm.launchConfig.loginLaunchStatus.description)"))
            Spacer()
            Button(action: { NSApp.terminate(nil) }) {
                Label("Quit", systemImage: "figure.run")
            }
            Spacer()
        }
    }
}

#Preview {
    BluetoothMenuBarView(coordinator: BluetoothCoordinator())
}
