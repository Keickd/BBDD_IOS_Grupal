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
    
    private var localPersistence = LocalPersistenceService.shared
    
    init(idTraining: UUID) {
        self.idTraining = idTraining
        self.training = localPersistence.getTrainingByID(id: idTraining)
    }
}

