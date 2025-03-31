//
//  User.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 20/12/24.
//

import Foundation

struct User: Codable {
    var name: String
    var age: Int
    var weight: Double
    var email: String
    var trainings: [Training] = []
}
