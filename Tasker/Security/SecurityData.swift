//  SecurityData.swift
//  Tasker
//
//  Created by Aleksej Shapran on 17.07.23

import SwiftUI
import LocalAuthentication

@MainActor
class SecurityData: ObservableObject {
    
    var error: NSError?
    
    @Published var isLocked = false
    @Published var isAppLockEnabled: Bool = UserDefaults.standard.object(forKey: "isAppLockEnabled") as? Bool ?? false
    
}

