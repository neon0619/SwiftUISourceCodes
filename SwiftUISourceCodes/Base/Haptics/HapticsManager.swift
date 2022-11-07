//
//  HapticsManager.swift
//  SwiftUISourceCodes
//
//  Created by Christopher Castillo on 8/24/22.
//

import Foundation
import UIKit

fileprivate final class HapticsManager {
    
    static let shared = HapticsManager()
    private let feedback = UINotificationFeedbackGenerator()
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
    
}


func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKey.hapticsEnabled) {
        HapticsManager.shared.trigger(notification)
    }
    
}
