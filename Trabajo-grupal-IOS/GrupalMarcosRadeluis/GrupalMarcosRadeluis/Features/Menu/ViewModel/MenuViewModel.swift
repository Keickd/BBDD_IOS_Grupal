//
//  MenuViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Radeluis on 13/4/25.
//

import Foundation

class MenuViewModel {
    let user: User? = nil
    
    private let localPersistenceService = LocalPersistenceService.shared
    
    func getUser() -> User? {
        return localPersistenceService.getUser()
    }
    
    func getSettings() -> AppSettings? {
        return localPersistenceService.appSettings
    }
}
