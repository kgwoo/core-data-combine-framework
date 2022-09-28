//
//  TaskListCell.swift
//  core-data-combine-framework
//
//  Created by GunWoo on 2022/09/28.
//

import SwiftUI

struct TaskListCell: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var taskListVM:TaskListViewModel
    @ObservedObject var taskListItem:TaskList
    @State private var isEdit = false
    
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                if taskListItem.isDone{
                    Text(taskListItem.title ?? "")
                        .foregroundColor(.gray)
                }else{
                    Text(taskListItem.title ?? "")
                }
                Text("\(taskListItem.date!.formatted(.dateTime.month().day().hour().minute().second()))")
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action:{}){
                Image(systemName: !taskListItem.isDone ? "circle" : "checkmark.circle")
            }
            .tint(.blue)
        }
        .sheet(isPresented: $isEdit){
            AddListView(addView: $isEdit)
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true){
            Button(action:{}){
                Label("Favorite", systemImage: taskListItem.isFavorite ? "heart.slash" : "heart")
            }
        }
        .swipeActions(edge: .trailing, allowsFullSwipe: false){
            Button(role:.destructive, action:{
                taskListVM.delete(task: taskListItem, context: viewContext)
            }){
                Label("Delete", systemImage: "trash")
            }
            Button(action:{
                isEdit.toggle()
                taskListVM.taskListItem = taskListItem
                taskListVM.taskListTitle = taskListItem.title ?? ""
            }){
                Label("Edit", systemImage: "pencil")
            }
        }
    }
}

//struct TaskListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskListCell()
//    }
//}
