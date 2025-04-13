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
    private let user: User?
    let appSetting: AppSettings?

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
        
        let training = Training()
        training.id = UUID()
        training.trainingType = trainingType.localized
        training.date = Date()
        training.route = routeJSON
        training.averageSpeed = getAverageSpeed()
        training.averageIntensity = getAverageIntensity()
        training.averageHeartRate = Int16(getAverageHeartRate())
        training.distance = motionManager.getDistance()
        training.calories = Int16(heartRateSimulator.getTotalCalories())
        training.steps = Int16(motionManager.getSteps())
        training.trainingTime = Int32(elapsedTime)
        
        if(user != nil && user?.email != nil){
            localPersistenceService.saveTraining(forEmail: self.user!.email!, training: training)
            return training.id
        }
        
        return nil
    }
}
