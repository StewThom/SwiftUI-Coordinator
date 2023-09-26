//
//  ContentView.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

struct HomeScreen: View {

	@EnvironmentObject var coordinator: MainCoordinator

	var body: some View {
		VStack {
			Button(action: presentModal) {
				Label("Open Modal", systemImage: "rectangle.stack")
			}
			Button(action: pushDetail) {
				Label {
					Text("Push Detail")
				} icon: {
					Image(systemName: "rectangle.portrait.and.arrow.forward")
						.environment(\.layoutDirection, .rightToLeft)
				}
			}

		}
		.toolbar {
			ToolbarItem(placement: .topBarTrailing) {
				Button(action: presentSettings) {
					Label("Show Settings", systemImage: "gear")
				}
			}
		}
		.navigationTitle("Test")
    }

	func presentModal() {
		let child = MainCoordinator()
		coordinator.present(child: child)
	}

	func pushDetail() {
		coordinator.push(route: .detail)
	}

	func presentSettings() {
		let settingsCoordinator = SettingsCoordinator()
		coordinator.present(child: settingsCoordinator)
	}
}

#Preview {
	HomeScreen()
}
