//
//  ITaskApp.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI
import SwiftData

@main
struct ITaskApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TaskModel.self
        ])
        //Para testing crear uno a parte que solo almacene en memoria
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(sharedModelContainer)
    }
}
