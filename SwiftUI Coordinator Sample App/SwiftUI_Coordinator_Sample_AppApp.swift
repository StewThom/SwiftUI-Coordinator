//
//  SwiftUI_Coordinator_Sample_AppApp.swift
//  SwiftUI Coordinator Sample App
//
//  Created by Stewart Thomson on 26/9/2023.
//

import SwiftUI

@main
struct SwiftUI_Coordinator_Sample_AppApp: App {

	let mainCoordinator = MainCoordinator()

	var body: some Scene {
		WindowGroup {
			mainCoordinator.rootView
		}
	}
}
