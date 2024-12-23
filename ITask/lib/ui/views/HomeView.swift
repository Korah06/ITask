//
//  ContentView.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [TaskModel]
    @State private var showAdd = false
    
    var body: some View {
        
        NavigationStack{
            VStack{
                if(tasks.isEmpty){
                    ContentUnavailableView("No hay Tareas", systemImage: "list.bullet.clipboard",description: Text("No hay tareas existentes, pulse el mas para crear una nueva tarea"))
                    Spacer()
                } else{
                    main
                }
            }.navigationTitle("Tareas")
                .toolbar{
                    ToolbarItem(placement: .primaryAction){
                        Button{
                            showAdd.toggle()
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            
        }.sheet(isPresented: $showAdd){
            NewTaskView(task:nil)
        }
        
    }
    
    var main: some View {
            List{
                ForEach(tasks){ task in
                    NavigationLink(destination: NewTaskView(task: task)){
                        TaskRow(task: task)
                    }
                }
                .onDelete{ index in
                    if let index = index.first {
                        let tasks = tasks
                        let task = tasks[index]
                        context.delete(task)
                    }
                }
            }
            
        //Esto es lo mismo que el sheet pero con este se ocupa toda la pantalla
//        .fullScreenCover(isPresented: $showAdd){
//            NewTaskView()
//        }
    }
}

#Preview(traits: .sampleData) {
    HomeView()
}
