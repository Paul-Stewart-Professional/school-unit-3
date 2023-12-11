//
//  coreDataEvenTimesApp.swift
//  coreDataEvenTimes
//
//  Created by Paul Stewart on 12/8/23.
//

import SwiftUI

@main
struct coreDataEvenTimesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
