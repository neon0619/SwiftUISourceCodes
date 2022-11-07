//
//  SwiftUISourceCodesApp.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/3/22.
//

import SwiftUI

@main
struct SwiftUISourceCodesApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        #if DEBUG
        print("👷🏽 Is UITest running: \(UITestingHelper.isUITesting)")
        #endif
        
        return true
    }
}
