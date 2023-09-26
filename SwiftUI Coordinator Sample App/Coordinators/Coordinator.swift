//
//  Coordinator.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import Foundation
import SwiftUI

struct AnyCoordinator: Identifiable {
	let id = UUID()
	let coordinator: any Coordinator
}

protocol Coordinator: ObservableObject {

	var parentCoordinator: (any Coordinator)? { get set }
	var childCoordinator: AnyCoordinator? { get set }

	func present(child: any Coordinator)

	associatedtype Content : View
	@ViewBuilder @MainActor var rootView: Content { get }

	associatedtype Route : Hashable
	var navigationPath: [Route] { get set }
	var navigationPathBinding: Binding<[Route]> { get }

	associatedtype Destination : View
	@ViewBuilder @MainActor func destination(for route: Route) -> Destination
}

extension Coordinator {
	func present(child: any Coordinator) {
		self.childCoordinator = AnyCoordinator(coordinator: child)
		child.parentCoordinator = self
	}

	func push(route: Route) {
		self.navigationPath.append(route)
	}

	var navigationPathBinding: Binding<[Route]> {
		Binding<[Route]> {
			return self.navigationPath
		} set: { newPath in
			self.navigationPath = newPath
		}
	}
}

struct WrapperView<Content: View, SomeCoordinator: Coordinator>: View {

	@ObservedObject var coordinator: SomeCoordinator
	@Binding var navigationPath: [SomeCoordinator.Route]
	let content: () -> Content

	init(coordinator: SomeCoordinator, navigationPath: Binding<[SomeCoordinator.Route]>, content: @escaping () -> Content) {
		self.coordinator = coordinator
		self._navigationPath = navigationPath
		self.content = content
	}

	var body: some View {
		NavigationStack(path: $navigationPath) {
			content()
				.navigationDestination(for: SomeCoordinator.Route.self) { route in
					coordinator
						.destination(for: route)
				}
		}
		.sheet(item: $coordinator.childCoordinator, content: { child in
			AnyView(child.coordinator.rootView)
		})
		.environmentObject(coordinator)
	}
}
