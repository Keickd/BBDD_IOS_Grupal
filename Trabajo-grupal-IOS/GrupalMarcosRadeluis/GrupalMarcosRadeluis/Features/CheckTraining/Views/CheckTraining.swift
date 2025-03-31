//
//  CheckTraining.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 16/1/25.
//

import SwiftUI
import MapKit

struct CheckTraining: View {
    @Binding var navigationPath: NavigationPath
    private var checkTrainingViewModel: CheckTrainingViewModel
    private let idTraining: UUID
    
    @State private var trainingType: String
    @State private var elapsedTime: Int = 0
    @State private var heartRate: Int = 70
    @State private var intensity: Double = 10
    @State private var speed: Double = 0
    @State private var distance: Double = 0
    @State private var steps: Int = 0
    @State private var calories: Int = 0
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var routeCoordinates: [IdentifiableCoordinate] = []
    
    init(idTraining: UUID, navigationPath: Binding<NavigationPath>) {
        self.idTraining = idTraining
        self.checkTrainingViewModel = CheckTrainingViewModel(idTraining: idTraining)
        self.trainingType = "Light Training"
        self._navigationPath = navigationPath
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Spacer()
                    Text(trainingType)
                        .font(.title)
                        .bold()
                    
                    HeartRate(heartRate: $heartRate, animationActive: false)
                        .padding(.bottom)
                    
                    CustomSlider(value: $intensity)
                        .padding(.bottom)
                    
                    Measures(speed: $speed, distance: $distance, steps: $steps, calories: $calories)
                        .padding(.bottom)
                    
                    TimerDisplay(timeElapsed: $elapsedTime, timerActive: .constant(false))
                    
                    CustomMap(region: $region, routeCoordinates: routeCoordinates)
                    .padding()
                    
                    Spacer()
                }
                .padding()
            }
        }
        .onAppear {
            loadTrainingData()
        }
    }
    
    func loadTrainingData() {
        if let training = checkTrainingViewModel.training {
            self.trainingType = training.type.localized
            self.calories = training.calories
            self.distance = training.distance
            self.elapsedTime = training.trainingTime
            self.heartRate = training.averageHeartRate
            self.intensity = training.averageIntensity
            self.speed = training.averageSpeed
            self.steps = training.steps
            
            if let coordinates = training.getRouteCoordinates(), !coordinates.isEmpty {
                self.routeCoordinates = coordinates.map { IdentifiableCoordinate(coordinate: $0) }
                self.region = MKCoordinateRegion(
                    center: coordinates.first!,
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            }
        }
    }
}

#Preview {
    CheckTraining(idTraining: UUID(), navigationPath: .constant(NavigationPath()))
}
