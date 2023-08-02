//  SecurityDataExtension.swift
//  Tasker
//
//  Created by Aleksej Shapran on 17.07.23


// MARK: - В этом экстеншне хранится полученная ошибка в случае, если не то лицо будет отсканированно, + переменная для хранения текущего состояния блокировки.
// Хранится все это в UserDefaults, если App Lock включен, чтобы приложение запомнило состояние, когда приложение будет убито в фоновом режиме.

import Foundation
import LocalAuthentication

// MARK: - тогл перемычки AppLock

extension SecurityData {
    
    func showLockedViewIfEnabled() {
        if isAppLockEnabled {
            isLocked = true
            authenticate()
        } else {
            isLocked = false
        }
    }
    
    func lockApp() {
        if isAppLockEnabled {
            isLocked = true
        } else {
            isLocked = false
        }
    }
}

// MARK: - Проверка состояния

extension SecurityData {
    
    func appLockStateChange(_ isEnabled: Bool) {
        let context = LAContext()
        let reason = "Пройдите аутентификацию для изменения состояния переменной"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                        self.isAppLockEnabled = isEnabled
                        UserDefaults.standard.set(self.isAppLockEnabled, forKey: "isAppLockEnabled")
                    }
                }
            }
        }
    }
        
}

// MARK: - Аутентификация

extension SecurityData {
    
    func authenticate() {
        let context = LAContext()
        let reason = "Пройдите аутентификацию с помощью FaceID"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                    }
                }
            }
        }
    }
    
}

