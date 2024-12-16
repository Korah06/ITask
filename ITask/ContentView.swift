//
//  ContentView.swift
//  ITask
//
//  Created by Mario Espasa Planells on 16/12/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var tasks: [TaskModel]
    @State private var showAdd = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(tasks){ task in
                    TaskRow(task: task)
                }
                .onDelete{ index in
                    if let index = index.first {
                        context.delete(tasks[index])
                    }
                }
            }
            .navigationTitle("Tasks")
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
            NewTaskView()
        }
        //Esto es lo mismo que el sheet pero con este se ocupa toda la pantalla
//        .fullScreenCover(isPresented: $showAdd){
//            NewTaskView()
//        }
    }
}

#Preview(traits: .sampleData) {
    ContentView()
}
