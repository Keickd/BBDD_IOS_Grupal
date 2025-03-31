//
//  StartStopButtons.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 17/1/25.
//

import SwiftUI

struct StartStopButtons: View {
    
    @Binding var timeElapsed: Int
    @Binding var timerActive: Bool
    var onStop: (() -> Void)?

    var body: some View {
        HStack(spacing: 16) {
            Button(action: pauseTimer) {
                HStack(spacing: 8) {
                    Image(systemName: timerActive ? "pause.circle" : "play.circle")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.title)

                    Text(timerActive ? "Pause" : "Play")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.title)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("ButtonColor"))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())

            Button(action: stopTimer) {
                HStack(spacing: 8) {
                    Image(systemName: "stop.circle")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.title)

                    Text("Stop")
                        .foregroundColor(Color("SecondaryTextColor"))
                        .font(.title)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color("ButtonColor"))
                .cornerRadius(10)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }

    private func pauseTimer() {
        timerActive.toggle()
    }

    private func stopTimer() {
        timerActive = false
        onStop?()
    }
}

#Preview {
    StartStopButtons(timeElapsed: .constant(100), timerActive: .constant(true), onStop: nil)
}
