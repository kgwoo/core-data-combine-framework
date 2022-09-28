//
//  TaskListView.swift
//  core-data-combine-framework
//
//  Created by GunWoo on 2022/09/28.
//

import Foundation
import Combine
import CoreData

class TaskListViewModel:ObservableObject{
    static var shared = TaskListViewModel()
    @Published var taskListTitle = ""
    @Published var taskListItem:TaskList!
    
    
    func createTask(context:NSManagedObjectContext){
        if taskListItem == nil{
            let task = TaskList(context: context)
        
            task.id = UUID()
            task.title = taskListTitle
            task.isDone = false
            task.isFavorite = false
            task.date = Date()
        }else{
            taskListItem.title = taskListTitle
        }
        save(context: context)
        taskListTitle = ""
    }
    
    func editList(task:TaskList){
        print(task, "응?")
        taskListItem = task
        taskListTitle = task.title ?? ""
        
    }
    
    func save(context:NSManagedObjectContext){
        do{
            try context.save()
        }catch{
            print("에러입니다: ",error)
        }
    }
    
    func delete(task:TaskList, context:NSManagedObjectContext){
        context.delete(task)
    }
}
