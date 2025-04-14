//
//  Menu.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 21/12/24.
//

import SwiftUI

struct Menu: View {
    @Binding var navigationPath: NavigationPath
    @State private var navigateToStartTraining: Bool = false
    @State private var navigateToCheckTrainings: Bool = false
    @State private var isUserRegistered: Bool = false
    @State private var showSideMenu: Bool = false
    
    private var menuVM = MenuViewModel()
    
    init(navigationPath: Binding<NavigationPath>) {
            self._navigationPath = navigationPath
        }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("Fitness App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .padding(.top, 40)

                Image("man_running")
                    .resizable()
                    .scaledToFit()
                    .padding(.top, 20)

                Button(action: {
                    if isUserRegistered {
                        navigationPath.append(AppRoute.chooseTraining)
                    } else {
                        navigationPath.append(AppRoute.signUpUser)
                    }
                }) {
                    Text("Start Training")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("ButtonColor"))
                        .foregroundColor(Color("SecondaryTextColor"))
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.horizontal)

                Button(action: {
                    navigationPath.append(AppRoute.listTrainings)
                }) {
                    Text("Check Trainings")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isUserRegistered ? Color("ButtonColor") : Color("DisabledColor"))
                        .foregroundColor(Color("SecondaryTextColor"))
                        .cornerRadius(10)
                }
                .disabled(!isUserRegistered)
                .buttonStyle(PlainButtonStyle())
                .padding()
            }
            SideMenu(navigationPath: $navigationPath, showSideMenu: $showSideMenu, isUserRegistered: $isUserRegistered)
        }
        .task {
            isUserRegistered = menuVM.user != nil
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    withAnimation(.easeInOut) {
                        showSideMenu.toggle()
                    }
                }) {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(!showSideMenu ? .primary : Color("BackgroundColor"))
                        .font(.title2)
                }
            }
        }
    }
}

/*#Preview {
    Menu(navigationPath: .constant(NavigationPath()))
}*/
