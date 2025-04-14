//
//  MenuViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Radeluis on 13/4/25.
//

import Foundation

class MenuViewModel {
    let user: User?
    
    private let localPersistenceService = LocalPersistenceService.shared
    
    init() {
        self.user = localPersistenceService.getUser()
    }
    
    func getSettings() -> AppSettings? {
        return localPersistenceService.appSettings
    }
}
