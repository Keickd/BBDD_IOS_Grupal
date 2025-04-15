//
//  SettingsViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Radeluis on 15/4/25.
//

import Foundation


class SettingsViewModel: ObservableObject {
    private let localPersistenceService = LocalPersistenceService.shared
    
    @Published var settings: AppSettings? = nil
    
    init() {
        loadSettings()
        self.settings = localPersistenceService.appSettings
    }
    
    func loadSettings() {
        localPersistenceService.loadSettings()
    }
    
    func saveSettings(alertSoundId: Int) throws {
        do{
            try localPersistenceService.saveAppSettings(alertSoundId: Int16(alertSoundId))
        }catch {
            print("Ha ocurrido un error al guardar la configiración. \(error.localizedDescription)")
        }
    }
}
