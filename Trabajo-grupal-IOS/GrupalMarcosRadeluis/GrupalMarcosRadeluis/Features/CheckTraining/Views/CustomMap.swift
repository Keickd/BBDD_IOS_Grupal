//
//  CustomMap.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 19/1/25.
//

import SwiftUI
import MapKit

struct CustomMap: View {
    @Binding var region: MKCoordinateRegion
    var routeCoordinates: [IdentifiableCoordinate]
    
    var body: some View {
        VStack {
            Text("Training route")
                .font(.title)
                .bold()
            
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: false, annotationItems: routeCoordinates) { location in
                MapPin(coordinate: location.coordinate)
            }
            .overlay {
                if !routeCoordinates.isEmpty {
                    MapRouteManager(routeCoordinates: routeCoordinates.map { $0.coordinate })
                }
            }
            .frame(height: 300)
            .cornerRadius(15)
            .padding()
        }
    }
}
