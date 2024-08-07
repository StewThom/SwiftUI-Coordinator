//
//  SettingsCoordinator.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

class SettingsCoordinator: Coordinator {

	enum NavigationRoute: String, CaseIterable {
		case notifications
		case account
		case security
	}

	weak var parentCoordinator: (any Coordinator)?
	@Published var childCoordinator: (any Coordinator)?
	@Published var navigationPath: [NavigationRoute] = []

	var rootView: some View {
		WrapperView(coordinator: self) {
			SettingsScreen()
		}
	}

	func destination(for route: NavigationRoute) -> some View {
		switch route {
			case .notifications:
				NotificationsSettingsScreen()
			case .security:
				SecuritySettingsScreen()
			case .account:
				AccountSettingsScreen()
		}
	}

	deinit {
		print("Deinit")
	}
}
