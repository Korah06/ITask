//
//  DataModel.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import Foundation
import SwiftData

enum TaskStatus: String, Codable,Identifiable,CaseIterable{
    case pending = "Pendiente"
    case inProgress = "En Progreso"
    case done = "Hecho"
    
    var id: Self { self }
}

@Model
final class TaskModel{
    @Attribute(.unique) var id: UUID
    var name: String
    var taskDescription: String
    var date: Date
    var status: TaskStatus
    
    init(id: UUID, name: String, description: String, date: Date, status: TaskStatus) {
        self.id = id
        self.name = name
        self.taskDescription = description
        self.date = date
        self.status = status
    }
}
