//
//  CheckTrainingViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 17/1/25.
//

import SwiftUI

struct CheckTrainingViewModel {

    var idTraining: UUID
    var training: Training?
    
    init(idTraining: UUID) {
        self.idTraining = idTraining
        self.training = UserDefaultsUtils.user?.trainings.first(where: { Training in
            Training.id == idTraining
        })
    }
}

