//
//  SampleData.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI
import SwiftData

struct SampleData: PreviewModifier {
    
    static func makeSharedContext() async throws -> ModelContainer {
        let schema = Schema([
            TaskModel.self
        ])
        //Para testing crear uno a parte que solo almacene en memoria
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [modelConfiguration])
        
        let task1 = TaskModel(id: UUID(), name: "Programar Swift", description: "Dedicarse al nuevo proyector de Swift", date: .now, status: .pending)
        let task2 = TaskModel(id: UUID(), name: "Salir a pasear con el perro", description: "Sacar al perro a pasear por la tarde con mi amigo Jose Luis", date: .now, status: .done)
        
        container.mainContext.insert(task1)
        container.mainContext.insert(task2)
        
        return container
    }
    
    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
    
}

extension PreviewTrait where T == Preview.ViewTraits{
    @MainActor static var sampleData: Self = .modifier(SampleData())
}
