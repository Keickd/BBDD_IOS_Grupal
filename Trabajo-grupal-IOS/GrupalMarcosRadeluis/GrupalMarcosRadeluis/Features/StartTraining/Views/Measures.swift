//
//  Measures.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 11/1/25.
//

import SwiftUI

struct Measures: View {
    
    @Binding var speed: Double
    @Binding var distance: Double
    @Binding var steps: Int
    @Binding var calories: Int
    
    var body: some View {
        VStack {
            HStack {
                GeometryReader { geometry in
                    HStack {
                        VStack {
                            Text("\(speed, specifier: "%.2f")")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .padding(.bottom, 5)
                                .minimumScaleFactor(0.7)
                            
                            Text("Speed (km/h)")
                                .font(.title3)
                                .foregroundColor(Color("DisabledColor"))
                        }
                        .frame(width: geometry.size.width / 2)

                        Divider()
                            .frame(width: 1, height: 80)
                            .background(Color("DisabledColor"))

                        VStack {
                            Text("\(distance, specifier: "%.2f")")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .padding(.bottom, 5)
                                .minimumScaleFactor(0.7)
                            
                            Text("Distance (km)")
                                .font(.title3)
                                .foregroundColor(Color("DisabledColor"))
                        }
                        .frame(width: geometry.size.width / 2)
                    }
                }
                .frame(height: 80)
            }
            .padding(.horizontal)

            Divider()
                .frame(height: 1.5)
                .background(Color("DisabledColor"))
                .padding(.horizontal)
                .padding(.vertical, 5)

            HStack {
                GeometryReader { geometry in
                    HStack {
                        VStack {
                            Text("\(steps)")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .padding(.bottom, 5)
                                .minimumScaleFactor(0.7)
                            
                            Text("Steps")
                                .font(.title3)
                                .foregroundColor(Color("DisabledColor"))
                        }
                        .frame(width: geometry.size.width / 2)

                        Divider()
                            .frame(width: 1, height: 80)
                            .background(Color("DisabledColor"))
                       

                        VStack {
                            Text("\(calories)")
                                .font(.system(size: 40, weight: .bold, design: .rounded))
                                .padding(.bottom, 5)
                                .minimumScaleFactor(0.7)
                            
                            Text("Calories (kcal)")
                                .font(.title3)
                                .foregroundColor(Color("DisabledColor"))
                        }
                        .frame(width: geometry.size.width / 2)
                    }
                }
                .frame(height: 80)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    Measures(speed: .constant(8.98), distance: .constant(5.56), steps: .constant(7455), calories: .constant(458))
}
