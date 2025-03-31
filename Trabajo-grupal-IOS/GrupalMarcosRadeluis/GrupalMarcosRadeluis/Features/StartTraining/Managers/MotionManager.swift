//
//  MotionManager.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 5/1/25.

import CoreMotion
import SwiftUI

class MotionManager {
    private let pedometer = CMPedometer()
    private let motionManager = CMMotionManager()
    private var speedValues: [Double] = []

    private var stepCount: Int = 0
    private var distance: Double = 0.0
    private var accumulatedSteps: Int = 0
    private var accumulatedDistance: Double = 0.0
    private var pace: Double = 0.0

    func startPedometerUpdates() {
        if CMPedometer.isStepCountingAvailable() {
            pedometer.startUpdates(from: Date()) { [weak self] data, error in
                guard let self = self, error == nil, let data = data else { return }
                
                self.pace = data.currentPace?.doubleValue ?? 0.0
                let newSteps = data.numberOfSteps.intValue
                let newDistance = data.distance?.doubleValue ?? 0.0
                
                self.stepCount = self.accumulatedSteps + newSteps
                self.distance = self.accumulatedDistance + newDistance
                
                self.speedValues.append(pace)
            }
        }
    }

    func stopPedometerUpdates() {
        pedometer.stopUpdates()
        motionManager.stopAccelerometerUpdates()
        
        accumulatedSteps = stepCount
        accumulatedDistance = distance
    }

    func reset() {
        stepCount = 0
        distance = 0.0
        accumulatedSteps = 0
        accumulatedDistance = 0.0
        pace = 0.0
    }

    func getSteps() -> Int {
        return stepCount
    }

    func getDistance() -> Double {
        return distance / 1000
    }

    func getSpeed() -> Double {
        if pace > 0 {
            return (3600.0 / pace) / 1000
        }
        return 0
    }
    
    func getAverageSpeed() -> Double {
        
        if speedValues.isEmpty {
            return 0
        }
        return speedValues.reduce(0, +) / Double(speedValues.count)
    }
}
