//
//  ImageListAppApp.swift
//  ImageListApp
//
//  Created by CP on 19/08/25.
//

import SwiftUI

@main
struct ImageListAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
