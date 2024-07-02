//
//  DetailScreen.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

struct DetailScreen: View {

	@EnvironmentObject var coordinator: MainCoordinator

    var body: some View {
        Text("Detail")
			.navigationTitle("Detail")
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					Button(action: presentSettings) {
						Label("Show Settings", systemImage: "gear")
					}
				}
			}
    }

	func presentSettings() {
		let settingsCoordinator = SettingsCoordinator()
		coordinator.present(child: settingsCoordinator)
	}
}

#Preview {
    DetailScreen()
}
