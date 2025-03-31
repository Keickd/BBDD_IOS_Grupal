//
//  Training.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 20/12/24.
//

import Foundation
import MapKit

struct Training: Codable, Identifiable {
    let id: UUID
    let type: TrainingType
    let date: Date
    let route: String
    let averageSpeed: Double
    let averageIntensity: Double
    let averageHeartRate: Int
    let distance: Double
    let calories: Int
    let steps: Int
    let trainingTime: Int
}

extension Training {
    func getRouteCoordinates() -> [CLLocationCoordinate2D]? {
        guard let routeData = route.data(using: .utf8),
              let coordinatesArray = try? JSONSerialization.jsonObject(with: routeData, options: []) as? [[String: Double]] else {
            return nil
        }
        return coordinatesArray.compactMap { dict in
            if let lat = dict["latitude"], let lon = dict["longitude"] {
                return CLLocationCoordinate2D(latitude: lat, longitude: lon)
            }
            return nil
        }
    }
}
