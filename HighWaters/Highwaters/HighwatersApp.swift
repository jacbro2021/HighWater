//
//  HighwatersApp.swift
//  Highwaters
//
//  Created by jacob brown on 7/9/23.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct HighwatersApp: App {
    
    //register app delegate for firebase start up
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            MapView(_vm: ContentViewModel())
        }
    }
}


