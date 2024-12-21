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
        HStack {
            VStack(alignment: .leading){
                Text(task.name).font(.headline)
                Text(task.date.formatted(date: .long, time: .omitted)).font(.subheadline).foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .center){
                Text(task.status.rawValue)
            }
        }
        
    }
}
