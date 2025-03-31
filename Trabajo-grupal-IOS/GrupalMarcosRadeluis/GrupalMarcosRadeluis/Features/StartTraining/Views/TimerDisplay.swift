//
//  TimeView.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 11/1/25.
//

import SwiftUI

struct TimerDisplay: View {
    @Binding var timeElapsed: Int
    @Binding var timerActive: Bool

    var body: some View {
        VStack {
            Text(timeString)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .scaledToFit()
                .minimumScaleFactor(0.7)

            Text("Time")
                .font(.title3)
                .scaledToFit()
                .foregroundColor(Color("DisabledColor"))
                .padding(.bottom)
        }
    }

    private var timeString: String {
        let hours = timeElapsed / 3600
        let minutes = (timeElapsed % 3600) / 60
        let seconds = timeElapsed % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

#Preview {
    TimerDisplay(timeElapsed: .constant(100), timerActive: .constant(true))
}

