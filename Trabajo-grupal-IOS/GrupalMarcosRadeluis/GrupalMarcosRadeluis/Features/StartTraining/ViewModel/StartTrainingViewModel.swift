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

    init(trainingType: TrainingType) {
        self.trainingType = trainingType
        self.heartRateSimulator = HeartRateSimulator(trainingType: trainingType)
        self.motionManager = MotionManager()
        self.locationManager = LocationManager()
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
        
        let training = Training(
            id: UUID(),
            type: trainingType,
            date: Date(),
            route: routeJSON,
            averageSpeed: getAverageSpeed(),
            averageIntensity: getAverageIntensity(),
            averageHeartRate: getAverageHeartRate(),
            distance: motionManager.getDistance(),
            calories: heartRateSimulator.getTotalCalories(),
            steps: motionManager.getSteps(),
            trainingTime: elapsedTime)
        if UserDefaultsUtils.addTraining(training: training){
            return training.id
        }
        return nil
    }
}
