//
//  AppRoutes.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 19/1/25.
//

import SwiftUI

enum AppRoute: Hashable{
    case listTrainings
    case chooseTraining
    case startTraining(trainingType: TrainingType)
    case checkTraining(idTraining: UUID)
    case signUpUser
    case settings
}
