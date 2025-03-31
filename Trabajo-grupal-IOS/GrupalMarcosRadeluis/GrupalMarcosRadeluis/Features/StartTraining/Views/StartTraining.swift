//
//  StartTraining.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 5/1/25.
//

import SwiftUI
import AVKit

struct StartTraining: View {

    private var trainingType: TrainingType
    private var startTrainingViewModel: StartTrainingViewModel
    @Binding var navigationPath: NavigationPath
    
    @State private var idTraining: UUID?
    @State private var isNavigationAvailable: Bool = false
    @State private var elapsedTime: Int = 0
    @State private var timer: Timer?
    @State private var measurementTimer: Timer?
    @State private var isTimerActive: Bool = true
    @State private var showAlertSaveTraining: Bool = false
    
    @State private var heartRate: Int = 70
    @State private var intensity: Double = 10
    @State private var speed: Double = 0
    @State private var distance: Double = 0
    @State private var steps: Int = 0
    @State private var calories: Int = 0

    init(trainingType: TrainingType, navigationPath: Binding<NavigationPath>) {
        self.trainingType = trainingType
        self.startTrainingViewModel = StartTrainingViewModel(
            trainingType: trainingType)
            self._navigationPath = navigationPath
        
    }
    
    var body: some View {
        ZStack {
            Color(
                "BackgroundColor"
            )
            .ignoresSafeArea()
                
            ScrollView {
                VStack {
                    Spacer()
                    HeartRate(
                        heartRate: $heartRate, animationActive: true
                    )
                    .padding(
                        .bottom
                    )
                    
                    CustomSlider(
                        value: $intensity
                    )
                    .padding(
                        .bottom
                    )
                    
                    Measures(
                        speed: $speed,
                        distance: $distance,
                        steps: $steps,
                        calories: $calories
                    )
                    .padding(
                        .bottom
                    )
                    
                    TimerDisplay(
                        timeElapsed: $elapsedTime,
                        timerActive: $isTimerActive
                    )
                    
                    StartStopButtons(
                        timeElapsed: $elapsedTime,
                        timerActive: $isTimerActive
                    ) {
                        showAlertSaveTraining = true
                    }
                    
                    Spacer()
                }
                .padding()
                .onAppear {
                    startTraining()
                    
                    timer = Timer
                        .scheduledTimer(
                            withTimeInterval: 1.0,
                            repeats: true
                        ) { _ in
                            if isTimerActive {
                                elapsedTime += 1
                                
                            }
                            
                            startTrainingViewModel.heartRateSimulator
                                .updateHeartRate(
                                    speed: speed
                                )
                            
                            heartRate = startTrainingViewModel.heartRateSimulator
                                .getCurrentHeartRate()
                            
                            intensity = startTrainingViewModel.heartRateSimulator
                                .calculateIntensity(
                                    heartRate: heartRate
                                )
                            
                            if isTimerActive {
                                calories = Int(
                                    startTrainingViewModel.heartRateSimulator.calculateCalories(
                                        weight: UserDefaultsUtils.user != nil ? UserDefaultsUtils.user!.weight : 70,
                                        elapsedTime: TimeInterval(
                                            1
                                        )
                                    )
                                )
                            }
                        }
                    
                    measurementTimer = Timer
                        .scheduledTimer(
                            withTimeInterval: 0.1,
                            repeats: true
                        ) { _ in
                            
                            if isTimerActive {
                                steps = startTrainingViewModel.motionManager
                                    .getSteps()
                                
                                distance = startTrainingViewModel.motionManager
                                    .getDistance()
                                
                                speed = startTrainingViewModel.motionManager
                                    .getSpeed()
                            }
                        }
                }
                .onDisappear {
                    stopTrainingWhenExit()
                }
                .onChange(
                    of: isTimerActive
                ) {
                    _,
                    __ in
                    PauseResumeTraining()
                }
                .alert(
                    isPresented: $showAlertSaveTraining
                ) {
                    Alert(
                        title: Text(
                            "End training?"
                        ),
                        message: Text(
                            "Do you wish to end the training?"
                        ),
                        primaryButton: 
                                .destructive(
                                    Text(
                                        "Close"
                                    )
                                ) {
                                    isTimerActive = true
                                    showAlertSaveTraining = false
                                },
                        secondaryButton: .default(Text("Save")) {
                            DispatchQueue.global(qos: .userInitiated).async {
                                stopTrackingData()

                                let id = startTrainingViewModel.saveTraining(trainingType: trainingType, elapsedTime: elapsedTime)

                                DispatchQueue.main.async {
                                    showAlertSaveTraining = false
                                    if id != nil {
                                        emitSound()
                                        idTraining = id
                                        isNavigationAvailable = true
                                        resetData()
                                        handleNavigation()
                                    }
                                }
                            }
                        }
                    )
                }
            }
        }
    }
    
    func startTraining() {
        startTrainingViewModel.locationManager
            .startTracking()
        startTrainingViewModel.motionManager
            .startPedometerUpdates()
        emitSound()
    }
    
    func stopTrackingData() {
        isTimerActive = false
        measurementTimer?.invalidate()
        timer = nil
        measurementTimer = nil
        
        startTrainingViewModel.locationManager
            .stopTracking()
        startTrainingViewModel.motionManager
            .stopPedometerUpdates()
    }
    
    func resetData() {
        elapsedTime = 0
        startTrainingViewModel.motionManager.reset()
    }
    
    
    func stopTrainingWhenExit() {
        stopTrackingData()
        resetData()
    }
    
    func PauseResumeTraining() {
        if isTimerActive {
            startTrainingViewModel.motionManager
                .startPedometerUpdates()
        } else {
            startTrainingViewModel.motionManager
                .stopPedometerUpdates()
        }
    }
    
    func handleNavigation() {
        navigationPath = NavigationPath()
        navigationPath.append(AppRoute.listTrainings)
        
        navigationPath.append(AppRoute.checkTraining(idTraining: idTraining!))
    }
    
    func emitSound() {
        if let soundId = UserDefaultsUtils.appSettings?.alertSoundId {
            AudioServicesPlayAlertSound(UInt32(soundId))
        }
        
    }
}

#Preview {
    StartTraining(trainingType: .LIGHT, navigationPath: .constant(NavigationPath()))
}
