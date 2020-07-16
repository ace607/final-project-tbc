//
//  UDManager.swift
//  news
//
//  Created by Admin on 7/5/20.
//  Copyright © 2020 Mishka TBC. All rights reserved.
//

import Foundation

class UDManager {
    static private let FINISHED_REGISTRATION_KEY = "FINISHED_REGISTRATION_KEY"
    
    static private let UDStandard = UserDefaults.standard
    
    static func setFinished() {
        UDStandard.set(true, forKey: FINISHED_REGISTRATION_KEY)
    }
    
    static func isFinished() -> Bool {
        return UDStandard.bool(forKey: FINISHED_REGISTRATION_KEY)
    }
    
}
