//
//  ContentView.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 19/12/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            Menu(navigationPath: $navigationPath)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .listTrainings:
                        TrainingList(navigationPath: $navigationPath)
                        
                    case .chooseTraining:
                        ChooseTraining(navigationPath: $navigationPath)
                        
                    case .startTraining(let trainingType):
                        StartTraining(trainingType: trainingType, navigationPath: $navigationPath)
                        
                    case .checkTraining(let idTraining):
                        CheckTraining(idTraining: idTraining, navigationPath: $navigationPath)
                        
                    case .signUpUser:
                        SignUpUser(navigationPath: $navigationPath, userWasRegistered: .constant(false))
                    
                    case .settings:
                        Settings()
                    }
            }
        }
    }
}

extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

#Preview {
    ContentView()
}
