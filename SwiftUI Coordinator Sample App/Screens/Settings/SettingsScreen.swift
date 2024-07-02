//
//  SettingsScreen.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

struct SettingsScreen: View {
	
	@Environment(\.dismiss) var dismiss
	@EnvironmentObject var coordinator: SettingsCoordinator

	@State var text: String = ""

    var body: some View {
		List {
			TextField("Text", text: $text)
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
				Button(action: coordinator.dismiss) {
					Label("Close", systemImage: "xmark.circle.fill")
				}
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
