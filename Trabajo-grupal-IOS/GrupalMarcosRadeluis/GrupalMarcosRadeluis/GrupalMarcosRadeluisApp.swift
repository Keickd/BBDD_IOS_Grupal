//
//  GrupalMarcosRadeluisApp.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 19/12/24.
//

import SwiftUI

@main
struct GrupalMarcosRadeluisApp: App {
    
    let persistenceManager = PersistenceManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }.environment(\.managedObjectContext, persistenceManager.container.viewContext)
    }
}
