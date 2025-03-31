//
//  TrainingList.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 18/1/25.
//

import SwiftUI

struct TrainingList: View {
    
    @Binding var navigationPath: NavigationPath
    
    @State var trainingList: [Training] = []
    private var trainingListViewModel: TrainingListViewModel = TrainingListViewModel()
    
    init(navigationPath: Binding<NavigationPath>){
        self._navigationPath = navigationPath
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            if trainingList.isEmpty {
                Text("There are no trainings")
                    .font(.title)
                    .foregroundColor(.black)
                    .padding()
            } else {
                List {
                    ForEach(trainingList) { training in
                        NavigationLink(destination: CheckTraining(idTraining: training.id, navigationPath: $navigationPath)) {
                            TrainingListItem(training: training)
                            .padding(.vertical, 5)
                        }
                    }
                    .onDelete(perform: deleteTraining)
                }
                .navigationTitle("Trainings")
                .scrollContentBackground(.hidden)
            }
        }.onAppear(){
            trainingList = trainingListViewModel.getTrainings()
        }
    }
    
    private func deleteTraining(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        
        let trainingId = trainingList[index].id
        
        if (trainingListViewModel.deleteTraining(idTraining: trainingId)) {
            trainingList = trainingListViewModel.getTrainings()
        }
    }
}

#Preview {
    TrainingList(navigationPath: .constant(NavigationPath()))
}
