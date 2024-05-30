//
//  HapticManager.swift
//  SwiftUICrypto
//
//  Created by Oğuzhan Abuhanoğlu on 30.05.2024.
//

import Foundation
import SwiftUI

class HapticManager {
    // this will make a little vibrate on users phone
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
