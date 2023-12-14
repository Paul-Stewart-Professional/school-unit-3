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
    
    
    // Create
    
    func createNewItem(with title: String) {
        let newItem = Item(context: PersistenceController.shared.viewContext)
        newItem.id = UUID().uuidString
        newItem.title = title
        newItem.createdAt = Date()
        newItem.completedAt = nil
        PersistenceController.shared.saveContext()
    }
    
    // Retrieve
    
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
    
    // Update
    
    func toggleItemCompletion(_ item: Item) {
        item.completedAt = item.isCompleted ? nil : Date()
        PersistenceController.shared.saveContext()
    }
    
    
//    
//    func delete(at indexPath: IndexPath) {
//        remove(item(at: indexPath))
//    }
//    
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
