//
// ContentView.swift
// PrivacySensitive
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!. PrivacySensitive")
            .privacySensitive(.default)
          
          Text("Hello, SwiftUI. RedactedPrivacyViewModifier!")
            .privacySensitive(.redacted)
          
          Text("Hello, SwiftUI. BlurPrivacyViewModifier!")
            .privacySensitive(.blur)

          Text("Hello, SwiftUI. OpacityPrivacyViewModifier!")
            .privacySensitive(.opacity)
          
          Text("Hello, SwiftUI. ColorPrivacyViewModifier!")
            .privacySensitive(.custom(color: .teal, cornerRadius: 20))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

enum PrivacySensitiveStyle {
  case `default`
  case redacted
  case blur
  case opacity
  case custom(color: Color, cornerRadius: CGFloat)
}

extension View {
  @ViewBuilder
  func privacySensitive(_ style: PrivacySensitiveStyle) -> some View {
    Group {
      switch style {
        case .default:
          privacySensitive()
        case .redacted:
          modifier(RedactedPrivacyViewModifier())
        case .blur:
          modifier(BlurPrivacyViewModifier())
        case .opacity:
          modifier(OpacityPrivacyViewModifier())
        case .custom(let color, let cornerRadius):
          modifier(ColorPrivacyViewModifier(color: color, cornerRadius: cornerRadius))
      }
    }
  }
}

struct RedactedPrivacyViewModifier: ViewModifier {
  @Environment(\.scenePhase) var scenePhase
  
  func body(content: Content) -> some View {
    content.redacted(reason: scenePhase == .active ? .init() : .placeholder)
      .animation(.default, value: scenePhase)
  }
}

struct BlurPrivacyViewModifier: ViewModifier {
  @Environment(\.scenePhase) var scenePhase
  
  func body(content: Content) -> some View {
    content.blur(radius: scenePhase != .active ? 5 : 0)
      .animation(.default, value: scenePhase)
  }
}

struct OpacityPrivacyViewModifier: ViewModifier {
  @Environment(\.scenePhase) var scenePhase
  
  func body(content: Content) -> some View {
    content.opacity(scenePhase != .active ? 0 : 1)
      .animation(.default, value: scenePhase)
  }
}

struct ColorPrivacyViewModifier: ViewModifier {
  @Environment(\.scenePhase) var scenePhase
  
  var color: Color
  var cornerRadius: CGFloat
  
  func body(content: Content) -> some View {
    content
      .overlay {
        color.opacity(scenePhase != .active ? 1 : 0)
          .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
      }
      .animation(.default, value: scenePhase)
  }
}
