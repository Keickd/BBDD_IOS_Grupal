//
//  LocationManager.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 15/1/25.
//

import CoreLocation
import SwiftUI
import MapKit

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    var locations: [CLLocation] = []
    var totalDistance: Double = 0.0
    var speed: Double = 0.0
    private let minimumDistanceThreshold: Double = 15.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkAuthorizationStatus()
    }

    private func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            startTracking()
        default:
            print("Ubicación no autorizada")
        }
    }

    func startTracking() {
        locationManager.startUpdatingLocation()
    }

    func stopTracking() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkAuthorizationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        for newLocation in newLocations {
            guard newLocation.horizontalAccuracy < 20 else { continue }
            if let lastLocation = locations.last {
                let distance = lastLocation.distance(from: newLocation)
                if distance >= minimumDistanceThreshold {
                    totalDistance += distance
                    locations.append(newLocation)
                }
            } else {
                locations.append(newLocation)
            }
        }

        if let latestLocation = newLocations.last {
            speed = latestLocation.speed >= 0 ? latestLocation.speed : 0
        }
    }

    func getRoutePolyline() -> MKPolyline {
        let coordinates = locations.map { $0.coordinate }
        return MKPolyline(coordinates: coordinates, count: coordinates.count)
    }

    func resetTracking() {
        locations.removeAll()
        totalDistance = 0.0
        speed = 0.0
    }
}
