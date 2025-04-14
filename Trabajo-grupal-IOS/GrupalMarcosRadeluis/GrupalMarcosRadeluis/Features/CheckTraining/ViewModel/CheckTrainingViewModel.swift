//
//  CheckTrainingViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 17/1/25.
//

import SwiftUI
import MapKit

struct CheckTrainingViewModel {

    var idTraining: UUID
    var training: Training?
    
    private var localPersistence = LocalPersistenceService.shared
    
    init(idTraining: UUID) {
        self.idTraining = idTraining
        self.training = localPersistence.getTrainingByID(id: idTraining)
    }
    
    func getRouteCoordinates() -> [CLLocationCoordinate2D]? {
        guard let routeData = training?.route?.data(using: .utf8),
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

