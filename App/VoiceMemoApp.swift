//
//  VoiceMemoApp.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/10.
//

import SwiftUI

@main
struct VoiceMemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
