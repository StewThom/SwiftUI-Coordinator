//
//  SettingsScreen.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

struct SettingsScreen: View {
	
	@EnvironmentObject var coordinator: SettingsCoordinator

    var body: some View {
		List {
			Section {
				Button("Notifications") {
					presentNavigationRoute(.notifications)
				}
			}
			Section {
				Button("Account") {
					presentNavigationRoute(.account)
				}
			}
			Section {
				Button("Security") {
					presentNavigationRoute(.security)
				}
			}
		}
		.toolbar {
			ToolbarItem(placement: .cancellationAction) {
				Button("Close", systemImage: "xmark.circle.fill", action: coordinator.dismiss)
			}
		}
		.navigationTitle("Settings")
    }

	func presentNavigationRoute(_ route: SettingsCoordinator.NavigationRoute) {
		coordinator.push(route: route)
	}
}

#Preview {
    SettingsScreen()
}
