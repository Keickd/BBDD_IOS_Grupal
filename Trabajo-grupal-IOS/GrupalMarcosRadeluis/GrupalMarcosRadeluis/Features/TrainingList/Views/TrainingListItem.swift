//
//  TrainingListItem.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 19/1/25.
//

import SwiftUI

struct TrainingListItem: View {
    let training: Training
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(training.type.localized)
                    .font(.headline)
                Text(formatDate(training.date))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(training.distance, specifier: "%.2f") km")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            VStack {
                Text(formatTrainingTime(training.trainingTime))
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                HStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color("ErrorColor"))
                    
                    Text("\(training.averageHeartRate)")
                        .font(.subheadline)
                }
            }
        }
        .padding(.vertical, 5)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func formatTrainingTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        
        if hours > 0 {
            return "\(hours)h \(minutes)m"
        } else if minutes > 0 {
            return "\(minutes)m \(remainingSeconds)s"
        } else {
            return "\(remainingSeconds)s"
        }
    }
}

#Preview {
    TrainingListItem(training: Training(id: UUID(), type: .INTENSE, date: Date(), route: "", averageSpeed: 5.5, averageIntensity: 67, averageHeartRate: 89, distance: 6.76, calories: 546, steps: 34534, trainingTime: 2345))
}
