//
//  journalEntryApp.swift
//  journalEntry
//
//  Created by Paul Stewart on 12/11/23.
//

import SwiftUI

@main
struct journalEntryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
