//
//  Item+Extension.swift
//  ToDo
//
//  Created by 王瑞果 on 2021/7/4.
//

import Foundation

extension Item {
    var unwrappedTitle: String {
        title ?? "New Item"
    }
    
    var unwrappedDueDate: Date {
        dueDate ?? Date()
    }
    
    var unwrappedNote: String {
        note ?? "Item Note"
    }
    
    var unwrappedCreateDateDate: Date {
        createDate ?? Date()
    }
    
    var unwrappedUpdateDate: Date {
        updateDate ?? Date()
    }
    
    static var example: Item {
        let item = Item(context: PersistenceController.shared.container.viewContext)
        item.id = UUID()
        item.title = "Example Item"
        item.dueDate = Date()
        item.note = "Item Note"
        item.createDate = Date()
        item.updateDate = Date()
        item.isCollected = false
        item.isCompleted = false
        return item
    }
}
