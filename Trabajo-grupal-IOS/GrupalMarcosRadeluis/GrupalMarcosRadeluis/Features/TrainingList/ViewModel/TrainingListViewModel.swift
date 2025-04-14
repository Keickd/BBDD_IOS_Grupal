//
//  TrainingListViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 18/1/25.
//

import Foundation

class TrainingListViewModel {
    private let localPersistenceService = LocalPersistenceService.shared
    
    func getTrainings() -> [Training] {
        return localPersistenceService.getTrainings()
    }
    
    func deleteTraining(idTraining: UUID) -> Bool{
        return localPersistenceService.deleteTraining(id: idTraining)
    }
}
