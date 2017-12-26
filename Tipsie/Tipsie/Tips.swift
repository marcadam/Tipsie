//
//  Constants.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/7/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import Foundation
import UIKit

struct Tips {
    static let double = [0.15,  0.18,  0.20,  0.23,  0.25]
    static let string = ["15%", "18%", "20%", "23%", "25%"]

    static let defaultTipIndexKey = "DefaultTipIndex"
    static let defaultTipIndexChangedKey = "DefaultTipIndexChanged"

    static func setTipControlText(_ control: UISegmentedControl) {
        for (index, tipText) in Tips.string.enumerated() {
            control.setTitle(tipText, forSegmentAt: index)
        }
    }

    static func setDefaultTipIndex(_ defaultTipIndex: Int) {
        let defaults = UserDefaults.standard
        defaults.set(defaultTipIndex, forKey: defaultTipIndexKey)
        Tips.setDefaultTipIndexChanged(true)
        defaults.synchronize()
    }

    static func getDefaultTipIndex() -> Int {
        let defaults = UserDefaults.standard
        return defaults.integer(forKey: defaultTipIndexKey)
    }

    static func setDefaultTipIndexChanged(_ changed: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(changed, forKey: defaultTipIndexChangedKey)
        defaults.synchronize()
    }

    static func getDefaultTipIndexChanged() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: defaultTipIndexChangedKey)
    }
}
