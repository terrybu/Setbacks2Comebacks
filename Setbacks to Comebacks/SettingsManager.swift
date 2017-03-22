//
//  SettingsManager.swift
//  TaoTeChingSwift
//
//  Created by David Weissler on 10/30/16.
//  Copyright © 2016 Bogil, John. All rights reserved.
//

import NotificationCenter

enum FontSize: Int {
    case small = 0, medium, large, count
    func label() -> String {
        switch self {
        case .small: return "Small"
        case .medium: return "Medium"
        case .large: return "Large"
        case .count: return ""
        }
    }
    
    func size() -> Float {
        switch self {
        case .small: return 14.0
        case .medium: return 16.0
        case .large: return 18.0
        case .count: return 0.0
        }
    }
}

final class SettingsManager {
    
    static let shared = SettingsManager()

    var fontSize: FontSize
    
    init() {
        if let savedSized = UserDefaults.standard.object(forKey: "FontSize") {
            fontSize = FontSize(rawValue: savedSized as! Int)!
        } else {
            fontSize = FontSize.medium
        }
    }

    func updateFontSize(fontSize: FontSize) {
        self.fontSize = fontSize

        UserDefaults.standard.set(fontSize.rawValue, forKey: "FontSize")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SettingsFontDidUpdate"), object: nil)
    }

}
