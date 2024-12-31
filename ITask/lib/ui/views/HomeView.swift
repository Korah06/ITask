//
//  ContentView.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI
import SwiftData

enum TasksFilter: String, Codable,Identifiable,CaseIterable{
    case all
    case pending
    case inProgress
    case done
    
    var id: Self { self }
}

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [TaskModel]
    @State private var showAdd = false
    @State private var filter: TasksFilter = .all
    
    var body: some View {
        let pendingTasks = tasks.filter{$0.status == .pending}
        let inProgressTasks = tasks.filter{$0.status == .inProgress}
        let doneTasks = tasks.filter{$0.status == .done}
        
        return NavigationStack{
            VStack{
                if(tasks.isEmpty || (filter == .pending && pendingTasks.isEmpty) || (filter == .inProgress && inProgressTasks.isEmpty) || (filter == .done && doneTasks.isEmpty)){
                    ContentUnavailableView("No hay Tareas", systemImage: "list.bullet.clipboard",description: Text("No hay tareas existentes, pulse el mas para crear una nueva tarea"))
                    Spacer()
                    Button{
                        showAdd.toggle()
                    } label: {
                        HStack{
                            Image(systemName: "plus.circle.fill")
                            Text("Nueva Tarea")
                        }
                    }
                } else{
                    main
                }
            }.navigationTitle("Tareas")
                .toolbar{
                    ToolbarItem(placement: .primaryAction){
                        Menu{
                            Button{
                                filter = .all
                            } label: {
                                Text("Mostrar Todo")
                            }
                            Button{
                                filter = .pending
                            } label: {
                                Text("Mostrar Pendientes")
                            }
                            Button{
                                filter = .inProgress
                            } label: {
                                Text("Mostrar En Progreso")
                            }
                            Button{
                                filter = .done
                            } label: {
                                Text("Mostrar Hecho")
                            }
                        } label: {Image(systemName: "line.3.horizontal")}
                        
                    }
                }
            
        }.sheet(isPresented: $showAdd){
            NewTaskView(task:nil)
        }
        
    }
    
    var main: some View {
        let pendingTasks = tasks.filter{$0.status == .pending}
        let inProgressTasks = tasks.filter{$0.status == .inProgress}
        let doneTasks = tasks.filter{$0.status == .done}
        
        return VStack {
            List{
                if !pendingTasks.isEmpty && (filter == .pending || filter == .all){
                    Section(header: Text("Pendientes")){
                        TaskList(tasks: pendingTasks)
                    }
                }
                
                if !inProgressTasks.isEmpty && (filter == .inProgress || filter == .all){
                    Section(header: Text("En progreso")){
                        TaskList(tasks: inProgressTasks)
                    }
                }
                
                if !doneTasks.isEmpty && (filter == .done || filter == .all){
                    Section(header: Text("Terminados")){
                        TaskList(tasks: doneTasks)
                    }
                }
            }
            Spacer()
            Button{
                showAdd.toggle()
            } label: {
                HStack{
                    Image(systemName: "plus.circle.fill")
                    Text("Nueva Tarea")
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
