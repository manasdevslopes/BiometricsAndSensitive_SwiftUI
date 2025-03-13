//
// ContentView.swift
// Sensitive_Analysis
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//


import SwiftUI
import SensitiveContentAnalysis

struct ContentView: View {
  
  enum AnalysisState {
    case notStarted
    case analyzing
    case isSensitive
    case notSensitive
    case error(message: String)
  }
  
  @State private var analysisState: AnalysisState = .notStarted
  @State private var errorMessage: String = ""
  
  var body: some View {
    VStack {
      HStack(spacing: 100) {
        Button {
          Task {
            await analyze(imageName: "iWriteNativeCode")
          }
        } label: {
          Text("Image 1").font(.largeTitle)
        }
        
        Button {
          Task {
            await analyze(imageName: "lena")
          }
        } label: {
          Text("Image 2").font(.largeTitle)
        }
      }
      .padding(.bottom, 50)
      
      Group {
        switch analysisState {
          case .notStarted:
            EmptyView()
          case .analyzing:
            ProgressView()
          case .isSensitive:
            Text("Warning! Image may contains sensitive content ⚠️")
          case .notSensitive:
            Text("The image is safe ✅")
          case .error(let message):
            Text("Error analyzing image: \(message)").foregroundStyle(.red)
        }
      }
    }
    .padding()
  }
  
  func analyze(imageName: String) async {
    analysisState = .analyzing
    let analyzer = SCSensitivityAnalyzer()
    let policy = analyzer.analysisPolicy
    if policy == .disabled {
      print("Policy is disabled")
      analysisState = .error(message: "Policy is disabled")
      return
    }
    
    // This is only works for offline url image (like from CoreData/SwiftData/AppStore/UserDefaults/FileManager etc.... It will not work with web url.
    // let response = try await analyzer.analyzeImage(url)
    // let handler = analyzer.videoAnalysis(forFileAt: videoFileUrl)
    // let response = try await handler.hasSensitiveContent()
    
    do {
      guard let image = UIImage(named: imageName) else {
        print("Image not found")
        analysisState = .error(message: "Image not found")
        return
      }
      let response = try await analyzer.analyzeImage(image.cgImage!)
      analysisState = response.isSensitive ? .isSensitive : .notSensitive
      if response.isSensitive {
        print("Warning! Image may contain sensitive content ⚠️")
      } else {
        print("Image is safe ✅")
      }
    } catch {
      analysisState = .error(message: error.localizedDescription)
      print("Unable to get a response: \(error.localizedDescription)")
    }
  }
}

#Preview {
  ContentView()
}
