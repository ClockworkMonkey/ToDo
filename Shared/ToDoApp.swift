//
//  ToDoApp.swift
//  Shared
//
//  Created by 王瑞果 on 2021/6/30.
//

import SwiftUI

@main
struct ToDoApp: App {
    @StateObject var persistenceController: PersistenceController
    
    init() {
        let persistenceController = PersistenceController.shared
        _persistenceController = StateObject(wrappedValue: persistenceController)
    }
    
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            iOSHomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(persistenceController)
            #endif
            
            #if os(macOS)
            macOSHomeView()
            #endif
        }
    }
}
