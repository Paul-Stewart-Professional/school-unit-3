//
//  ItemManager.swift
//  ToDoist
//
//  Created by Parker Rushton on 10/21/22.
//

import Foundation
import CoreData

class ItemManager {
    static let shared = ItemManager()
    
    var allItems = [Item]()
    private let context = PersistenceController.shared.viewContext

    
    
    // MARK: - Create
    
    
    // item
    func createNewItem(with title: String, toDoList: ToDoList) {
        let newItem = Item(context: context)
        newItem.id = UUID().uuidString
        newItem.title = title
        newItem.createdAt = Date()
        newItem.completedAt = nil
        newItem.toDoList = toDoList
        PersistenceController.shared.saveContext()
    }
    // to do list
    func createNewToDoList(with title: String) {
        let newToDo = ToDoList(context: context)
        newToDo.id = UUID().uuidString
        newToDo.title = title
        newToDo.createdAt = Date()
        newToDo.modifiedAt = Date()
        PersistenceController.shared.saveContext()
    }
    
    func allLists() -> [ToDoList] {
        let fetchRequest = ToDoList.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "modifiedAt", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedLists = try? context.fetch(fetchRequest)
        return fetchedLists ?? []
    }
    
    // MARK: - Retrieve
    
    //items
    
    private func fetchItems(matching predicate: NSPredicate, sortDescriptorKey: String) -> [Item] {
        let fetchRequest = Item.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: sortDescriptorKey, ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        do {
            let context = PersistenceController.shared.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching items: \(error)")
            return []
        }
    }
    
    //to do lists
    
    private func fetchToDos(matching predicate: NSPredicate, sortDescriptorKey: String) -> [ToDoList] {
        let fetchRequest = ToDoList.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "createdAt != nil", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.predicate = predicate
        do {
            let context = PersistenceController.shared.viewContext
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching To Do List: \(error.localizedDescription)")
            return []
        }
    }
    
    
    func fetchIncompleteItems() -> [Item] {
        return fetchItems(matching: NSPredicate(format: "completedAt == nil"), sortDescriptorKey: "createdAt")
    }
    
    func fetchCompleteItems() -> [Item] {
        return fetchItems(matching: NSPredicate(format: "completedAt != nil"), sortDescriptorKey: "completedAt")
    }
    
    
    //
    //    func incompleteItems() -> [Item] {
    //        let incomplete = allItems.filter { $0.completedAt == nil }
    //        return incomplete.sorted(by: { $0.sortDate >  $1.sortDate })
    //    }
    
    func completedItems() -> [Item] {
        let completed = allItems.filter { $0.completedAt != nil }
        return completed.sorted(by: { $0.sortDate >  $1.sortDate })
    }
    
    // MARK: - Update
    
    func toggleItemCompletion(_ item: Item) {
        item.completedAt = item.isCompleted ? nil : Date()
        PersistenceController.shared.saveContext()
    }
    
    
//    
//    func delete(at indexPath: IndexPath) {
//        remove(item(at: indexPath))
//    }
    
//  MARK: - Delete
    
    func remove(_ item: Item) {
        let context = PersistenceController.shared.viewContext
        context.delete(item)
        PersistenceController.shared.saveContext()
    }
    
    func item(at indexPath: IndexPath) -> Item {
        let items = indexPath.section == 0 ? fetchIncompleteItems() : fetchCompleteItems()
        return items[indexPath.row]
    }
}
