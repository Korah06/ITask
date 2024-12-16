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
    
    @State var name: String = ""
    @State var description: String = ""
    @State var date: Date = Date()
    @State var status: TaskStatus = .pending
    var body: some View {
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
            }.textFieldStyle(.roundedBorder).navigationTitle("Nueva tarea").toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button{
                        let newTask = TaskModel(id: UUID(), name: name, description: description, date: date, status: status)
                        context.insert(newTask)
                        dismiss()
                    } label: {
                        Text("Crear")
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
        }
    }
}

#Preview(traits: .sampleData) {
    NewTaskView()
}
