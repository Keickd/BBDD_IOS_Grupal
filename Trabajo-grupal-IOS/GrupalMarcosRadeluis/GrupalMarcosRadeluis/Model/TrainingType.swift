//
//  TrainingType.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 20/12/24.
//

import Foundation

enum TrainingType: String, Codable {
    case LIGHT = "Light Training"
    case INTENSE = "Heavy Training"
    
    var localized: String {
         return NSLocalizedString(self.rawValue, comment: "")
     }
}
