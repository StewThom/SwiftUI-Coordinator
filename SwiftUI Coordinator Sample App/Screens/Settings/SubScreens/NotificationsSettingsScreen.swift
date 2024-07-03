//
//  NotificationsSettingsScreen.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

struct NotificationsSettingsScreen: View {

	@EnvironmentObject var coordinator: SettingsCoordinator

    var body: some View {
		VStack {
			Text("Notifications")
				.navigationTitle("Notifications")
			Button(action: presentMain) {
				Label("Open Modal", systemImage: "rectangle.stack")
			}
		}
    }

	func presentMain() {
		let mainCoordinator = MainCoordinator()
		coordinator.present(child: mainCoordinator)
	}
}

#Preview {
    NotificationsSettingsScreen()
}
