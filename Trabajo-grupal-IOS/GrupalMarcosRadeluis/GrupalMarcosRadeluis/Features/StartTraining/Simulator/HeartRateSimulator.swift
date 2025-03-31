//
//  HeartRateSimulator.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 15/1/25.
//

import Foundation

class HeartRateSimulator {
    private var baseHeartRate: Int = 70
    private var currentHeartRate: Int = 70
    private var heartRateValues: [Int] = []
    
    private var currentSpeed: Double = 0.0

    private var trainingType: TrainingType
    
    private let heartRateIncreaseFactor: Int = 5
    private let intenseFactor: Double
    private let fluctuationFactor: Int = 5
    
    private var intensity: Double = 0
    private var intensityValues: [Double] = []
    
    private var totalCalories: Double = 0.0
    
    init(trainingType: TrainingType) {
        self.trainingType = trainingType
        self.intenseFactor = trainingType == .INTENSE ? 2.3 : 1.8
    }
    
    func updateHeartRate(speed: Double) {
        currentSpeed = speed
        var heartRateIncrease = Int(currentSpeed * Double(heartRateIncreaseFactor))
        
        if trainingType == .INTENSE {
            heartRateIncrease = Int(Double(heartRateIncrease) * intenseFactor)
        }
        
        let fluctuation = Int.random(in: -fluctuationFactor...fluctuationFactor)
        currentHeartRate = baseHeartRate + heartRateIncrease + fluctuation
        
        if currentHeartRate < 60 { currentHeartRate = 60 }
        if currentHeartRate > 180 { currentHeartRate = 180 }
        
        heartRateValues.append(currentHeartRate)
    }
    
    func calculateIntensity(heartRate: Int) -> Double {
        let minHeartRate = 60
        let maxHeartRate = 180
        let minIntensity = 0.0
        let maxIntensity = 100.0
        
        if heartRate <= minHeartRate {
            intensity = minIntensity
        } else if heartRate >= maxHeartRate {
            intensity = maxIntensity
        } else {
            intensity = (Double(heartRate - minHeartRate) / Double(maxHeartRate - minHeartRate)) * (maxIntensity - minIntensity)
        }
        
        intensityValues.append(intensity)
        return intensity
    }

    func calculateCalories(weight: Double, elapsedTime: TimeInterval) -> Double {
        let metabolicEquivalent = 3.5 + (Double(currentHeartRate - 60) / 20.0)
        let caloriesPerMinute = (metabolicEquivalent * 3.5 * weight) / 200
        let caloriesForThisInterval = caloriesPerMinute * (elapsedTime / 60.0)
        
        totalCalories += caloriesForThisInterval
        return totalCalories
    }
    
    func getCurrentHeartRate() -> Int {
        return currentHeartRate
    }
    
    func getTotalCalories() -> Int {
        return Int(totalCalories)
    }
    
    func getAverageIntensity() -> Double {
        return intensityValues.reduce(0, +) / Double(intensityValues.count)
    }
    
    func getAverageHeartRate() -> Int {
        return Int(heartRateValues.reduce(0, +)) / Int(heartRateValues.count)
    }
}
