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
    static let double = [0.18,   0.20,  0.22]
    static let string = ["18%", "20%", "22%"]

    static let defaultTipIndexKey = "DefaultTipIndex"
    static let defaultTipIndexChangedKey = "DefaultTipIndexChanged"

    static func setTipControlText(control: UISegmentedControl) {
        for (index, tipText) in Tips.string.enumerate() {
            control.setTitle(tipText, forSegmentAtIndex: index)
        }
    }

    static func setDefaultTipIndex(defaultTipIndex: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipIndex, forKey: defaultTipIndexKey)
        Tips.setDefaultTipIndexChanged(true)
        defaults.synchronize()
    }

    static func getDefaultTipIndex() -> Int {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.integerForKey(defaultTipIndexKey)
    }

    static func setDefaultTipIndexChanged(changed: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(changed, forKey: defaultTipIndexChangedKey)
        defaults.synchronize()
    }

    static func getDefaultTipIndexChanged() -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        return defaults.boolForKey(defaultTipIndexChangedKey)
    }
}
