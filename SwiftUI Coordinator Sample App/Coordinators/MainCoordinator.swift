//
//  TestCoordinator.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import Foundation
import SwiftUI

class MainCoordinator: Coordinator {

	enum NavigationRoute: String {
		case settings
		case detail
	}

	weak var parentCoordinator: (any Coordinator)?
	@Published var childCoordinator: (any Coordinator)?
	@Published var navigationPath: [NavigationRoute] = []

	var rootView: some View {
		WrapperView(coordinator: self) {
			HomeScreen()
		}
	}

	func destination(for route: NavigationRoute) -> some View {
		switch route {
			case .settings:
				SettingsScreen()
			case .detail:
				DetailScreen()
		}
	}
}
