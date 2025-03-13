//
// RootView.swift
// LocalAuthenticationDemo
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
// MARK: - Root View
import SwiftUI

struct RootView: View {
  @State private var authManager = AuthViewModel()
  
  var body: some View {
    VStack {
      if authManager.isAuthenticated {
        ContentView()
      } else {
         LockedView().environment(authManager)
      }
    }
    .task {
      await authManager.authenticate()
    }
  }
}
