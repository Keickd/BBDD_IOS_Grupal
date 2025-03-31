//
//  SideMenu.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 24/12/24.
//

import SwiftUI

struct SideMenu: View {
    @Binding var navigationPath: NavigationPath
    @Binding var showSideMenu: Bool
    @Binding var isUserRegistered: Bool
    @State private var navigateToSignUp: Bool = false
    @State private var navigateToSettings: Bool = false

    var body: some View {
        ZStack(alignment: .trailing) {
            if showSideMenu {
                Color.primary.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            showSideMenu = false
                        }
                    }
                    .transition(.opacity)
            }

            if showSideMenu {
                VStack(alignment: .leading) {
                    Spacer().frame(height: 20)
                    
                    Text("Fitness App")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("SecondaryTextColor"))
                        .padding()
                    
                    Image("man_running")
                        .resizable()
                        .frame(width: 180, height: 180)
                        .padding(.top, 20)
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color("SecondaryTextColor"))
                        .padding(.horizontal)

                    Button(action: {
                        navigateToSignUp = true
                    }) {
                        Label("Profile", systemImage: "person.fill")
                            .font(.title2)
                            .padding()
                            .foregroundColor(Color("SecondaryTextColor"))
                    }
                    
                    NavigationLink(destination: Settings()){
                        Label("Settings", systemImage: "gearshape.fill")
                            .font(.title2)
                            .padding()
                            .foregroundColor(Color("SecondaryTextColor"))
                    }

                    Spacer()
                }
                .frame(width: 250)
                .background(Color("ButtonColor"))
                .offset(x: showSideMenu ? 0 : -250)
                .animation(.easeInOut, value: showSideMenu)
                .transition(.move(edge: .trailing))
            }
        }
        .navigationDestination(isPresented: $navigateToSignUp) {
            SignUpUser(navigationPath: $navigationPath, userWasRegistered: $isUserRegistered)
        }
    }
}

#Preview {
    SideMenu(navigationPath: .constant(NavigationPath()), showSideMenu: .constant(true), isUserRegistered: .constant(true))
}
