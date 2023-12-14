//
//  ToDoList.swift
//  ToDoist
//
//  Created by Paul Stewart on 12/14/23.
//
//

import Foundation

extension ToDoList {
    var itemsArray: [Item] {
        let set = items as? Set<Item> ?? []
        return Array(set)
    }
}
