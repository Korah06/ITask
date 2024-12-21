//
//  NewTaskView.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let task: TaskModel?
    
    @State var name: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var status: TaskStatus = .pending
    var body: some View {
        let isEdit = task != nil
        //Form for create a row in TaskModel
        NavigationStack{
            Form {
                VStack(alignment: .leading){
                    Text("Nombre de la tarea")
                        .font(.headline)
                        .padding(.leading,5)
                    TextField("Ingrese el nombre de la tarea", text: $name)
                    
                }
                VStack(alignment: .leading){
                    Text("Descripción de la tarea")
                        .font(.headline)
                        .padding(.leading,5)
                    TextField("Ingrese la descripción de la tarea", text: $description)
                }
                DatePicker(selection: $date,displayedComponents: .date){
                    Text("Fecha de la tarea")
                }
                Picker(selection: $status){
                    ForEach(TaskStatus.allCases){ task in
                        Text(task.rawValue)
                    }
                } label: {
                    Text("Estado de la tarea")
                }
            }.textFieldStyle(.roundedBorder).navigationTitle(isEdit ? "Editar tarea" : "Nueva tarea").toolbar{
                
                if !isEdit {
                    ToolbarItem(placement: .confirmationAction){
                        Button{
                            if isEdit, let task = task{
                                task.name = name
                                task.taskDescription = description
                                task.date = date
                                task.status = status
                                dismiss()
                                return
                            }
                            let newTask = TaskModel(id: UUID(), name: name, description: description, date: date, status: status)
                            context.insert(newTask)
                            dismiss()
                        } label: {
                            Text(isEdit ? "Editar" :"Crear")
                        }
                    }
                    ToolbarItem(placement: .cancellationAction){
                        Button{
                            dismiss()
                        }label: {
                            Text("Cancelar")
                        }
                    }
                }
                if isEdit {
                    ToolbarItem(placement: .confirmationAction){
                        Button{
                            if isEdit, let task = task{
                                task.name = name
                                task.taskDescription = description
                                task.date = date
                                task.status = status
                                dismiss()
                                return
                            }
                            let newTask = TaskModel(id: UUID(), name: name, description: description, date: date, status: status)
                            context.insert(newTask)
                            dismiss()
                        } label: {
                            Text(isEdit ? "Editar" :"Crear")
                        }
                    }
                }
            }
        }.onAppear{
            if let task = task {
                name = task.name
                description = task.taskDescription
                date = task.date
                status = task.status
            }
        }
    }
}

#Preview(traits: .sampleData) {
    NewTaskView(task: TaskModel(id: UUID(), name: "Example", description: "Example", date: Date(), status: TaskStatus.done))
//    NewTaskView(task: nil)
}
