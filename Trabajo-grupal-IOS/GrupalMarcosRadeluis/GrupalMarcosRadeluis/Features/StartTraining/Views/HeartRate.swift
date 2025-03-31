//
//  HeartRate.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 11/1/25.
//

import SwiftUI

struct HeartRate: View {
    
    @Binding var heartRate: Int
    @State private var scale: CGFloat = 1.5
    var animationActive: Bool
    
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 15) {
                Text("\(heartRate)")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .scaledToFit()
                    .minimumScaleFactor(0.7)
                    .lineLimit(1)
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("ErrorColor"))
                    .scaleEffect(scale)
                    .onAppear {
                        if (animationActive){
                            withAnimation(
                                Animation.easeInOut(duration: 0.8)
                                    .repeatForever(autoreverses: true)
                            ) {
                                scale = 1.2
                            }
                        }
                    }
            }
            
            Text("Heart rate (bpm)")
                .font(.title3)
                .scaledToFit()
                .foregroundColor(Color(
                    "DisabledColor"
                ))
        }
    }
}

#Preview {
    HeartRate(heartRate: .constant(80), animationActive: true)
}
