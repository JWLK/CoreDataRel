//
//  CoreDataRelApp.swift
//  CoreDataRel
//
//  Created by JWLK on 2021/06/14.
//

import SwiftUI

@main
struct CoreDataRelApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
