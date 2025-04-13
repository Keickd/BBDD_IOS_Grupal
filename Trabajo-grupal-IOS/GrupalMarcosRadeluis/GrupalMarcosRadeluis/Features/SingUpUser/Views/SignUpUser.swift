//
//  SignUpUser.swift
//  GrupalMarcosRadeluis
//
//  Created by Marcos Salas on 21/12/24.
//

import SwiftUI

struct SignUpUser: View {
    let signUpUserVM = SignUpUserViewModel()
    
    @Binding var navigationPath: NavigationPath
    @State private var user: User
    @State private var nameIsValid: Bool = true
    @State private var ageIsValid: Bool = true
    @State private var weightIsValid: Bool = true
    @State private var emailIsValid: Bool = true
    
    @State private var nameWasEdited: Bool = false
    @State private var ageWasEdited: Bool = false
    @State private var weightWasEdited: Bool = false
    @State private var emailWasEdited: Bool = false

    @State private var dataSavedSuccessfully: Bool = false
    @State private var dataSavedFailed: Bool = false
    @State private var goToStartTraining: Bool = false
    @State private var appearButtonContinue: Bool = false
    @Binding var userWasRegistered: Bool

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    
    func validateFields() {
        nameIsValid = ((user.name?.isEmpty) != nil)
        ageIsValid = user.age > 0 && user.age <= 150
        weightIsValid = user.weight > 0
        emailIsValid = isValidEmail(user.email ?? "")
    }
    
    func isFormValid() -> Bool {
        return nameIsValid && ageIsValid && weightIsValid && emailIsValid
    }
    
    init(navigationPath: Binding<NavigationPath>, userWasRegistered: Binding<Bool>) {
        self._navigationPath = navigationPath
        self._userWasRegistered = userWasRegistered
    }

    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            Form {
                Section {
                    LabeledContent("Name") {
                        TextField("Enter your name", text: $user.name)
                            .onChange(of: user.name, initial: false, {
                                nameWasEdited = true
                                validateFields()
                            })
                            .font(.title3)
                            .multilineTextAlignment(.trailing)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        nameWasEdited && !nameIsValid ? Color("ErrorColor") : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    }
                    .font(.title2)
                    .foregroundStyle(.primary)
                    
                    LabeledContent("Age") {
                        TextField("Enter your age", text: Binding(
                            get: { user.age == 0 ? "" : "\(user.age)" },
                            set: { user.age = Int($0) ?? 0 }
                            ))
                            .keyboardType(.numberPad)
                            .onChange(of: user.age, initial: false, {
                                ageWasEdited = true
                                validateFields()
                            })
                            .font(.title3)
                            .multilineTextAlignment(.trailing)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        ageWasEdited && !ageIsValid ? Color("ErrorColor") : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    }
                    .font(.title2)
                    .foregroundStyle(.primary)

                    LabeledContent("Weight") {
                        TextField("Enter your weight", text: Binding(
                            get: { user.weight > 0 ? String(format: "%.1f", user.weight) : "" },
                            set: { newValue in
                                if let weight = Double(newValue), weight > 0 {
                                    user.weight = weight
                                    weightIsValid = true
                                } else {
                                    user.weight = 0
                                    weightIsValid = false
                                }
                                weightWasEdited = true
                            }
                        ))
                        .keyboardType(.decimalPad)
                        .font(.title3)
                        .multilineTextAlignment(.trailing)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    weightWasEdited && !weightIsValid ? Color("ErrorColor") : Color.clear,
                                    lineWidth: 1
                                )
                        )
                    }

                    .font(.title2)
                    .foregroundStyle(.primary)

                    LabeledContent("Email") {
                        TextField("Enter your email", text: $user.email)
                            .onChange(of: user.email, initial: false, {
                                emailWasEdited = true
                                validateFields()
                            })
                            .font(.title3)
                            .keyboardType(.emailAddress)
                            .multilineTextAlignment(.trailing)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(
                                        emailWasEdited && !emailIsValid ? Color("ErrorColor") : Color.clear,
                                        lineWidth: 1
                                    )
                            )
                    }
                    .font(.title2)
                    .foregroundStyle(.primary)
                    
                    Button(action: {
                        let result = signUpUserVM.saveUser(userFunc: user)
                        if result {
                            dataSavedSuccessfully = true
                            signUpUserVM.loadUser()
                        } else {
                            dataSavedFailed = true
                        }
                    }) {
                        Text("Save")
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                            .background(isFormValid() ? Color("ButtonColor") : Color("DisabledColor"))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .disabled(!isFormValid())
                }
                
                if appearButtonContinue && !userWasRegistered {
                    Section {
                        Button(action: {
                            navigationPath.append("ChooseTraining")
                            goToStartTraining = true
                        }) {
                            HStack {
                                Text("Continue")
                                Image(systemName: "arrow.right.circle")
                            }
                            .font(.title)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 10)
                            .background(isFormValid() ? Color("ButtonColor") : Color("DisabledButton"))
                            .foregroundColor(Color("SecondaryTextColor"))
                            .cornerRadius(8)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(.top)
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Sign Up")
        .navigationBarTitleDisplayMode(.large)
        .navigationDestination(isPresented: $goToStartTraining) {
            ChooseTraining(navigationPath: $navigationPath)
        }
        .alert("Data saved successfully", isPresented: $dataSavedSuccessfully) {
            Button("OK") {
                appearButtonContinue = true
            }
        }
        .alert("There was an error saving data", isPresented: $dataSavedFailed) { }
        .task {
            signUpUserVM.loadUser()
            if signUpUserVM.user != nil {
                user = signUpUserVM.user!
                validateFields()
            }else{
                validateFields()
            }
        }
    }
    
}

#Preview {
    SignUpUser(navigationPath: .constant(NavigationPath()), userWasRegistered: .constant(false))
}
