//
//  Setting.swift
//  GrupalMarcosRadeluis
//
//  Created by Radeluis on 3/1/25.
//

import Foundation

class AppSettings: Codable {
    var alertSoundId: Int = 1005
    
    init(alertSoundId: Int) {
        self.alertSoundId = alertSoundId
    }
}
