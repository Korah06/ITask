//
//  TaskList.swift
//  ITask
//
//  Created by Mario Espasa Planells on 22/12/24.
//

import SwiftUI

struct TaskList: View {
    @Environment(\.modelContext) private var context
    let tasks: [TaskModel]
    var body: some View {
        ForEach(tasks){ task in
            NavigationLink(destination: NewTaskView(task: task)){
                TaskRow(task: task)
            }
        }
        .onDelete{ index in
            if let index = index.first {
                let task = tasks[index]
                context.delete(task)
            }
        }
    }
}

#Preview {
    TaskList(tasks: [
        TaskModel(id: UUID(), name: "Programar Swift", description: "Dedicarse al nuevo proyector de Swift", date: .now, status: .pending),
        TaskModel(id: UUID(), name: "Programar Swift", description: "Dedicarse al nuevo proyector de Swift", date: .now, status: .pending)
    ])
}
