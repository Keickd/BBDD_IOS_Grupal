//
//  StartTraining.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 24/12/24.
//

import SwiftUI

struct ChooseTraining: View {
    @Binding var navigationPath: NavigationPath
    @State private var selectedTraining: TrainingType = .LIGHT
    let trainingOptions: [TrainingType] = [.LIGHT, .INTENSE]

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Choose your training")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding()
                

                Picker("Training Type", selection: $selectedTraining) {
                    ForEach(trainingOptions, id: \.self) { option in
                        Text(option.localized)
                            .font(.title)
                            .padding()
                    }
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
                .padding(.horizontal)
                
                Button(action: {
                    navigationPath.append(AppRoute.startTraining(trainingType: selectedTraining))
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "play.circle")
                            .foregroundColor(Color("SecondaryTextColor"))
                            .font(.title)

                        Text("Play")
                            .foregroundColor(Color("SecondaryTextColor"))
                            .font(.title)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ButtonColor"))
                    .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)
            }
        }
        .navigationTitle("Training")
    }
}

#Preview {
    ChooseTraining(navigationPath: .constant(NavigationPath()))
}
