//
// Sensitive_AnalysisApp.swift
// Sensitive_Analysis
//
// Created by MANAS VIJAYWARGIYA on 13/03/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    
// This can be done in iOS 17+. And it reuired paid Apple Developer Account
/*
 Steps: -
 1. Go to Capabilities -> select "Sensitive Content Analysis". This entitlement is only available for individual Paid Account, & free and Enterprise Accounts can't use this capabilites. Then check for Entitlement, it must be added to ur project.
 2. Now activate sensitive analysis in ur iPhone. There are 2 ways: -
     a. In iPhone's settings, goto "Privacy & Security", then scroll down to "Sensitive Content Warning" and toggle it on.
     b. In iPhone's settings, goto "Screen Time", then activate the toggle in "Communication Safety".
 */

/*
 Important Apple Developer links - https://developer.apple.com/documentation/sensitivecontentanalysis/detecting-nudity-in-media-and-providing-intervention-options
     https://developer.apple.com/documentation/sensitivecontentanalysis/testing-your-app-s-response-to-sensitive-media
 */
import SwiftUI

@main
struct Sensitive_AnalysisApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
