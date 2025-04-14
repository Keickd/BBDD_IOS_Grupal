//
//  StartTrainingViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 16/1/25.
//

import Foundation

class StartTrainingViewModel {
    
    var locationManager: LocationManager
    var motionManager: MotionManager
    var heartRateSimulator: HeartRateSimulator
    var trainingType: TrainingType
    
    private let localPersistenceService = LocalPersistenceService.shared
    let user: User?
    let appSetting: AppSettings?
    
    var id = UUID()
    var date = Date()
    var route = ""
    var averageSpeed = 0.0
    var averageIntensity = 0.0
    var averageHeartRate: Int16 = 0
    var distance = 0.0
    var calories: Int16 = 0
    var steps: Int16 = 0
    var trainingTime: Int32 = 0

    init(trainingType: TrainingType) {
        self.trainingType = trainingType
        self.heartRateSimulator = HeartRateSimulator(trainingType: trainingType)
        self.motionManager = MotionManager()
        self.locationManager = LocationManager()
        self.user = localPersistenceService.getUser()
        self.appSetting = localPersistenceService.getAppSettings()
    }
    
    func getAverageSpeed() -> Double {
        return motionManager.getAverageSpeed()
    }
    
    func getAverageIntensity() -> Double {
        return heartRateSimulator.getAverageIntensity()
    }
    
    func getAverageHeartRate() -> Int {
        return heartRateSimulator.getAverageHeartRate()
    }

    func saveTraining(trainingType: TrainingType, elapsedTime: Int) -> UUID?{
        let coordinates = locationManager.locations.map { location in
            ["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude]
        }
        guard let routeData = try? JSONSerialization.data(withJSONObject: coordinates, options: []),
              let routeJSON = String(data: routeData, encoding: .utf8) else {
            print("Error al convertir la ruta a JSON")
            return nil
        }
        
        if(user != nil && user?.email != nil){
            localPersistenceService.saveTraining(forEmail: self.user!.email!, id: id,trainingType:  trainingType.rawValue, date: date, route: routeJSON, averageSpeed: averageSpeed, averageIntensity: averageIntensity, averageHeartRate: averageHeartRate, distance: distance, calories: calories, steps: steps, trainingTime: trainingTime)
            return id
        }
        
        return nil
    }
}
