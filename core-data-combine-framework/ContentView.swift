//
//  ContentView.swift
//  core-data-combine-framework
//
//  Created by GunWoo on 2022/09/28.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var taskListVM:TaskListViewModel
    @FetchRequest(entity: TaskList.entity(), sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)]) var fetchedTaskList:FetchedResults<TaskList>
    @State private var addView = false
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(fetchedTaskList){ item in
                        TaskListCell(taskListItem: item)
                    }
                }
            }
            .sheet(isPresented: $addView, content: {
                AddListView(addView: $addView)
                    .environmentObject(taskListVM)
            })
            .navigationTitle("Core Data Memo")
            .navigationBarItems(trailing:
                 addView ?
                    nil : Button(action:{
                        addView.toggle()
                    }){
                        Label("Add Item", systemImage: "plus")
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
