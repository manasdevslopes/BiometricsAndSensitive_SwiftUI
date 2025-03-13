//
// AuthViewModel.swift
// LocalAuthenticationDemo
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import LocalAuthentication

// MARK: - ViewModel
@Observable
@MainActor
class AuthViewModel {
  var authStatus: AuthStatus = .idle
  var isAuthenticated: Bool { authStatus == .authenticated }
  
  func authenticate() async {
    let context = LAContext()
    var error: NSError?
    
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      let reason = "Authenticate to access the app"
      
      let success = await withCheckedContinuation { continuation in
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {success, _ in
          continuation.resume(returning: success)
        }
      }
      
      self.authStatus = success ? .authenticated : .failed
    } else {
      self.authStatus = .failed
    }
  }
}

/*
 Summary
 Use .deviceOwnerAuthentication instead of .deviceOwnerAuthenticationWithBiometrics to allow automatic fallback to passcode.
 If Face ID is available, it will be used first.
 After multiple failed attempts, a fallback option appears to "Use Passcode" or "Cancel".
 With .deviceOwnerAuthenticationWithBiometrics, selecting the fallback option results in an LAError.Code.userFallback error instead of showing the passcode screen.
 With .deviceOwnerAuthentication, biometrics are used if available, and passcode fallback happens automatically when biometrics fail.
 Conclusion: If you use biometrics authentication, you must handle the fallback manually. Using deviceOwnerAuthentication ensures seamless fallback to passcode when needed.
 */
