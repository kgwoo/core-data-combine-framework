//
//  core_data_combine_frameworkApp.swift
//  core-data-combine-framework
//
//  Created by GunWoo on 2022/09/28.
//

import SwiftUI

@main
struct core_data_combine_frameworkApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var taskListVM = TaskListViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskListVM)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
