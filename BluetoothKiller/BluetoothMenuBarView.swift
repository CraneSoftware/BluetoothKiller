//
//  BluetoothMenuBarView.swift
//  BluetoothKiller
//
//  Created by Will Crane on 1/18/24.
//

import SwiftUI

struct BluetoothMenuBarView: View {
    @State var isOn: Bool = false
    @State var coordinator: BluetoothMenuBarCoordinator

    var body: some View {
        VStack {
            Divider()
            Text("Bluetooth Killer")
                .padding()

            List {
                Section(header: Text("Devices")) {
                    ForEach(Array(coordinator.deviceConnections), id: \.key) { name, isConnected in
                        HStack {
                            Toggle("", isOn: $isOn)
                                .toggleStyle(.checkbox)
                            Text(name)
                            Spacer()
                            Image(systemName: "antenna.radiowaves.left.and.right" + (isConnected ? "" : ".slash"))
                        }
                        .padding(6)
                    }
                }
            }
//                Text("Login at Launch: ".appending("\(vm.launchConfig.loginLaunchStatus.description)"))
            Button(action: { NSApp.terminate(nil) }) {
                Label("Quit", systemImage: "figure.run")
            }
            .padding()
        }
    }
}

#Preview {
    BluetoothMenuBarView(coordinator: BluetoothMenuBarCoordinator())
}
