//
//  task_managerApp.swift
//  task_manager
//
//  Created by Maher Parkar on 7/9/2025.
//

import SwiftUI

@main
struct task_managerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
