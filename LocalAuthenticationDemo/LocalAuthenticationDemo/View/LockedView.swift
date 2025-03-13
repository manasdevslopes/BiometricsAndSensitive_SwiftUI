//
// LockedView.swift
// LocalAuthenticationDemo
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import LocalAuthentication

struct LockedView: View {
  @Environment(AuthViewModel.self) var authManager
  
  var body: some View {
    VStack {
      ContentUnavailableView("Authentication Required", systemImage: "faceid", description: Text("Use \(LAContext().biometricType.rawValue) to unlock"))
        .frame(height: 200)
      Button {
        Task {
          await authManager.authenticate()
        }
      } label: {
        Text("Authenticate")
      }
      .buttonStyle(.borderedProminent).tint(.orange)
    }
  }
}

#Preview {
  LockedView().environment(AuthViewModel())
}
