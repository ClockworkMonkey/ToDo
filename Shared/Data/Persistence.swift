//
//  Persistence.swift
//  ToDo
//
//  Created by 王瑞果 on 2021/7/4.
//

import CoreData

class PersistenceController: ObservableObject {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "ToDo")
        container.loadPersistentStores { persistentStoreDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    static var viewContext: NSManagedObjectContext = {
        let persistenceController = PersistenceController.shared
        return persistenceController.container.viewContext
    }()
    
    func save() -> Bool {
        let persistenceController = PersistenceController.shared
        if persistenceController.container.viewContext.hasChanges {
            do {
                try persistenceController.container.viewContext.save()
            } catch {
                return false
            }
        }
        return true
    }
}

extension PersistenceController {
    @discardableResult
    func createItem(title: String, dueDate: Date, note: String?, isCollected: Bool) -> Bool {
        let item = Item(context: PersistenceController.shared.container.viewContext)
        item.id = UUID()
        item.serialNumber = 0
        item.title = title
        item.dueDate = dueDate
        item.note = note
        item.isCollected = isCollected
        item.isCompleted = false
        item.createDate = Date()
        item.updateDate = Date()
        return save()
    }
    
    @discardableResult
    func updateItem(_ item: Item) -> Bool {
        item.updateDate = Date()
        return save()
    }
    
    @discardableResult
    func deleteItem(_ item: Item) -> Bool {
        PersistenceController.shared.container.viewContext.delete(item)
        return save()
    }
}
