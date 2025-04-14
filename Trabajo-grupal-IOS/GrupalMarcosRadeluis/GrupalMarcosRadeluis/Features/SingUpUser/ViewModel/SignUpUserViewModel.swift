//
//  SignUpUserViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Radeluis on 12/4/25.
//

import Foundation

class SignUpUserViewModel{
    private let localPersistenceService = LocalPersistenceService.shared
    
    var user: User?
    var name: String?
    var age: Int16?
    var weight: Double?
    var email: String?
    
    init() {
        self.user = getUSer()
    }
    
    
    func addUser(name: String, age: Int16, weight: Double, email: String) -> Bool {
        localPersistenceService.saveUser(
            name: name,
            age: age,
            weight: weight,
            email: email
        )
        return true
    }
    
    func getUSer() -> User? {
        return localPersistenceService.getUser()
    }
}
