//
// ScrollOffsetPreferenceKey.swift
// LocalAuthenticationDemo
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
import Foundation
import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
  typealias Value = CGPoint
  static var defaultValue: CGPoint = .zero
  
  static func reduce(value _: inout CGPoint, nextValue _: () -> CGPoint) { }
}
