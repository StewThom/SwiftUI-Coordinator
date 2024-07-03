//
//  Coordinator.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import Foundation
import SwiftUI

protocol Coordinator: ObservableObject {

	var parentCoordinator: (any Coordinator)? { get set }
	var childCoordinator: (any Coordinator)? { get set }

	func present(child: any Coordinator)
	func dismiss()
	func push(route: Route)

	associatedtype Content : View
	@ViewBuilder @MainActor var rootView: Content { get }

	associatedtype Route : Hashable
	var navigationPath: [Route] { get set }

	associatedtype Destination : View
	@ViewBuilder @MainActor func destination(for route: Route) -> Destination
}

extension Coordinator {
	func present(child: any Coordinator) {
		self.childCoordinator = child
		child.parentCoordinator = self
	}

	func push(route: Route) {
		self.navigationPath.append(route)
	}

	func dismiss() {
		DispatchQueue.main.async {
			self.parentCoordinator?.childCoordinator = nil
		}
	}

	var showChild: Binding<Bool> {
		Binding<Bool> { [weak self] in
			self?.childCoordinator != nil
		} set: { [weak self] newValue in
			if newValue == false {
				DispatchQueue.main.async {
					self?.childCoordinator = nil
				}
			}
		}
	}

}

struct WrapperView<Content: View, SomeCoordinator: Coordinator>: View {

	unowned var coordinator: SomeCoordinator
	var content: () -> Content

	var body: some View {
		NavigationHandlingView {
			content()
		}
		.environmentObject(coordinator)
	}
}

extension WrapperView {
	struct NavigationHandlingView: View {

		@EnvironmentObject var coordinator: SomeCoordinator
		var content: () -> Content

		var body: some View {
			NavigationStack(path: $coordinator.navigationPath) {
				content()
					.navigationDestination(for: SomeCoordinator.Route.self, destination: { route in
						coordinator.destination(for: route)
					})
			}
			.sheet(isPresented: coordinator.showChild) {
				if let childCoordinator = coordinator.childCoordinator {
					AnyView(childCoordinator.rootView)
				}
			}
		}
	}
}
