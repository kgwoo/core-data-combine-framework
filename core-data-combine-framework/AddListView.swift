//
//  AddListView.swift
//  core-data-combine-framework
//
//  Created by GunWoo on 2022/09/28.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var taskListVM:TaskListViewModel
    @Binding var addView:Bool
    
    var body: some View {
        NavigationView{
            Form{
                VStack{
                    TextField("제목 입력", text:$taskListVM.taskListTitle)
                    Button(action:{
                        taskListVM.createTask(context: viewContext)
//                        taskListVM.taskListItem == nil ? taskListVM.createTask(context: viewContext) : taskListVM.editList(task: taskListVM.taskListItem)
                        addView.toggle()
                    }){
                        Text("추가")
                            .frame(minWidth:0, maxWidth: .infinity)
                    }
                }
                .tint(.yellow)
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle)
            }
            .navigationTitle(taskListVM.taskListItem == nil ? "Add Item" : "Edit Item")
        }
    }
}

//struct AddListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddListView()
//    }
//}
