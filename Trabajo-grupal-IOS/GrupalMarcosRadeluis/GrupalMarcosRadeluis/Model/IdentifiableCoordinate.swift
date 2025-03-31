//
//  IdentifiableCoordinate.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 19/1/25.
//

import CoreLocation

struct IdentifiableCoordinate: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
