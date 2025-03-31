//
//  UserDefaultsUtils.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 21/12/24.
//

import Foundation

struct UserDefaultsUtils {
    private static let userKey = "currentUser"
    private static let appSettingsKey = "appSettings"
    
    static var user: User? = nil
    static var appSettings: AppSettings? = nil
    
    static func saveUser(userFunc: User) -> Bool{
        let defaults = UserDefaults.standard
        do {
            let encodedData = try JSONEncoder().encode(userFunc)
            defaults.set(encodedData, forKey: userKey)
            return true
        } catch {
            return false
        }
    }
    
    static func loadUser() {
        let defaults = UserDefaults.standard
        do {
            if let userData = defaults.data(forKey: userKey) {
                user = try JSONDecoder().decode(User.self, from: userData)
            }
        } catch {
            print("Failed to load user: \(error)")
        }
    }
    
    static func addTraining(training: Training) -> Bool {
        if user != nil {
            user!.trainings.append(training)
            return saveUser(userFunc: user!)
        } else {
            print("No user found to add training.")
        }
        return false
    }
    
    static func deleteTraining(trainingId: UUID) -> Bool {
        if user != nil {
            user!.trainings.removeAll { training in
                training.id == trainingId
            }
            return saveUser(userFunc: user!)
        } else {
            print("No user found to delete training.")
        }
        return false
    }
    
    
    static func saveSettings(_ settings: AppSettings) -> Bool{
        let defaults = UserDefaults.standard
        do {
            let encodedData = try JSONEncoder().encode(settings)
            defaults.set(encodedData, forKey: appSettingsKey)
            return true
        } catch {
            print("Error when saving Settings: \(error)")
            return false
        }
    }
    
    static func loadSettings() {
        let defaults = UserDefaults.standard
        do {
            if let settingsData = defaults.data(forKey: appSettingsKey) {
                 appSettings = try JSONDecoder().decode(AppSettings.self, from: settingsData)
            } else {
                appSettings = AppSettings(alertSoundId: 1005)
            }
        } catch {
            print("Failed to load app settings \(error)")
        }
    }
}
