//
//  LocalPersistenceService.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 31/3/25.
//

import Foundation
import CoreData

@Observable
final class LocalPersistenceService {
    static let shared = LocalPersistenceService()

    let context: NSManagedObjectContext

    private init() {
        context = PersistenceManager.shared.container.viewContext
    }

    private(set) var user: User?
    private(set) var appSettings: AppSettings?
    
    //USER
        
    func loadUser() {
        user = getUser()
    }

    func getUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try context.fetch(request).first
        } catch {
            print("Error al obtener el usuario: \(error.localizedDescription)")
            return nil
        }
    }
    
    func saveUser(name: String, age: Int16, weight: Double, email: String) {
        let newUser = User(context: context)
        newUser.name = name
        newUser.age = age
        newUser.weight = weight
        newUser.email = email

        saveContext()
        loadUser()
        print("Usuario guardado correctamente")
    }

    func updateUser(email: String, newName: String?, newAge: Int16?, newWeight: Double?) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            if let user = try context.fetch(request).first {
                if let newName = newName {
                    user.name = newName
                }
                if let newAge = newAge {
                    user.age = newAge
                }
                if let newWeight = newWeight {
                    user.weight = newWeight
                }
                
                saveContext()
                loadUser()
                print("Usuario actualizado correctamente")
            } else {
                print("No se encontró un usuario con el email \(email)")
            }
        } catch {
            print("Error al actualizar el usuario: \(error.localizedDescription)")
        }
    }
    
    //TRAININGS
    
    func loadTrainings() {
        user?.trainings = NSSet(array: getTrainings())
    }

    func saveTraining(
        forEmail email: String,
        id: UUID,
        trainingType: String,
        date: Date,
        route: String?,
        averageSpeed: Double,
        averageIntensity: Double,
        averageHeartRate: Int16,
        distance: Double,
        calories: Int16,
        steps: Int16,
        trainingTime: Int32
    ) {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            if let user = try context.fetch(request).first {
                let newTraining = Training(context: context)
                newTraining.id = id
                newTraining.trainingType = trainingType
                newTraining.date = date
                newTraining.route = route
                newTraining.averageSpeed = averageSpeed
                newTraining.averageIntensity = averageIntensity
                newTraining.averageHeartRate = averageHeartRate
                newTraining.distance = distance
                newTraining.calories = calories
                newTraining.steps = steps
                newTraining.trainingTime = trainingTime
                
                user.addToTrainings(newTraining)
                saveContext()
                print("Entrenamiento guardado correctamente")
            } else {
                print("No se encontró el usuario con email \(email)")
            }
        } catch {
            print("Error al guardar el entrenamiento: \(error.localizedDescription)")
        }
    }
    
    func getTrainings() -> [Training] {
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Error al obtener los entrenamientos: \(error.localizedDescription)")
            return []
        }
    }
    
    func getTrainingByID(id: UUID) -> Training? {
        let request: NSFetchRequest<Training> = Training.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Error al obtener el entrenamiento con ID \(id): \(error.localizedDescription)")
            return nil
        }
    }
    
    func updateTraining(id: UUID, newData: Training) -> Bool {
        guard let training = getTrainingByID(id: id) else {
            print("No se encontró el entrenamiento con ID \(id)")
            return false
        }

        training.trainingType = newData.trainingType
        training.date = newData.date
        training.route = newData.route
        training.averageSpeed = newData.averageSpeed
        training.averageIntensity = newData.averageIntensity
        training.averageHeartRate = newData.averageHeartRate
        training.distance = newData.distance
        training.calories = newData.calories
        training.steps = newData.steps
        
        saveContext()
        return true
    }
    
    func deleteTraining(id: UUID) -> Bool {
        guard let training = getTrainingByID(id: id) else {
            print("No se encontró el entrenamiento con ID \(id)")
            return false
        }

        context.delete(training)
        
        saveContext()
        return true
    }

    //APP SETTINGS
    
    func loadSettings() {
        appSettings = getAppSettings()
    }
    
    func saveAppSettings(alertSoundId: Int16) throws {
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        
        do {
            let settings = try context.fetch(request).first ?? AppSettings(context: context)
            settings.alertSoundId = alertSoundId
            
            saveContext()
        } catch {
            print("Error al guardar la configuración: \(error.localizedDescription)")
        }
    }
    
    func getAppSettings() -> AppSettings? {
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Error al obtener la configuración: \(error.localizedDescription)")
            return nil
        }
    }

    // GENERAL
    
    private func saveContext() {
        do {
            if context.hasChanges {
                try context.save()
            }
        } catch {
            print("Error al guardar cambios en Core Data: \(error.localizedDescription)")
        }
    }
}
