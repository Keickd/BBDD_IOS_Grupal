//
//  BBDDPersistence.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 31/3/25.
//

import CoreData

struct PersistenceManager {
  static let shared = PersistenceManager()
    let container: NSPersistentContainer
    var spotlightDelegate: NSCoreDataCoreSpotlightDelegate

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "TrainingApp")
    if inMemory {
      container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
    }

      guard let description = container.persistentStoreDescriptions.first else {
          fatalError("App creating persistencestore")
      }
    
      description.type = NSSQLiteStoreType
      description.setOption(true as NSNumber, forKey: NSPersistentHistoryTrackingKey)
      
    container.loadPersistentStores { storeDescription, error in
        if error != nil {
        fatalError("App crashes when trying to configure Core Data")
      }
    }
      
      spotlightDelegate = NSCoreDataCoreSpotlightDelegate(forStoreWith: description, coordinator: container.persistentStoreCoordinator)
      spotlightDelegate.startSpotlightIndexing()
  }
}



