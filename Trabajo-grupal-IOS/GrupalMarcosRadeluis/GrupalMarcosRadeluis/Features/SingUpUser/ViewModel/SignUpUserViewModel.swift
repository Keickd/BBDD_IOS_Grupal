//
//  SignUpUserViewModel.swift
//  GrupalMarcosRadeluis
//
//  Created by Radeluis on 12/4/25.
//

import Foundation

class SignUpUserViewModel{
    private let localPersistenceService = LocalPersistenceService.shared
    
    var user: User
    
    init() {
        self.user = localPersistenceService.getUser() ?? User()
    }
    
    
    func addUser(user: User) {
        localPersistenceService.saveUser(
            name: user.name!,
            age: user.age,
            weight: user.weight,
            email: user.email!
        )
    }
}
