//
//  TrainingListViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 18/1/25.
//

import Foundation

class TrainingListViewModel {
    
    func getTrainings() -> [Training] {
        return UserDefaultsUtils.user?.trainings ?? []
    }
    
    func deleteTraining(idTraining: UUID) -> Bool{
        return UserDefaultsUtils.deleteTraining(trainingId: idTraining)
    }
}
