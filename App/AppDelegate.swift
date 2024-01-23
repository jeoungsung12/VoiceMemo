//
//  AppDelegate.swift
//  VoiceMemo
//
//  Created by 정성윤 on 2024/01/10.
//

import Foundation
import UIKit

class AppDelegate : NSObject, UIApplicationDelegate{
    var notificationDelegate = NotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = notificationDelegate
        return true
    }
}
