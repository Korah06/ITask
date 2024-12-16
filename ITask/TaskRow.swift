//
//  TaskRow.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI

struct TaskRow: View {
    let task: TaskModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text(task.name).font(.headline)
            HStack {
                Text(task.date.formatted(date: .long, time: .omitted))
                Spacer()
                Text(task.status.rawValue)
            }.font(.subheadline).foregroundStyle(.secondary)
        }
    }
}
