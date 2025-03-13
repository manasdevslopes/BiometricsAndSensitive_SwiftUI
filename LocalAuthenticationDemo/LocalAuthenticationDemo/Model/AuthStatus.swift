//
// AuthStatus.swift
// LocalAuthenticationDemo
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI
import LocalAuthentication

// MARK: - Model
enum AuthStatus {
  case authenticated, failed, idle
}

// MARK: - LAContext Extension
extension LAContext {
  enum BiometricType: String {
    case none = "None"
    case touchID = "Touch ID"
    case faceID = "Face ID"
    case opticID = "Optic ID"
  }
  
  var biometricType: BiometricType {
    switch self.biometryType {
      case .none:
        return .none
      case .touchID:
        return .touchID
      case .faceID:
        return .faceID
      case .opticID:
        return .opticID
      @unknown default:
        return .none
    }
  }
}
