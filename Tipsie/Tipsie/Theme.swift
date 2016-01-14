//
//  Theme.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/8/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    enum Name: Int {
        case Light, Dark
    }

    private let darkBackgroundColor = UIColor.themeDarkBackgroundColor()
    private let darkTextColor = UIColor.themeDarkTextColor()

    private let lightBackgroundColor = UIColor.themeLightBackgroundColor()
    private let lightTextColor = UIColor.themeLightTextColor()

    var backgroundColor: UIColor
    var textColor: UIColor

    private let defaultThemeKey = "DefaultTheme"

    static let sharedInstance = Theme()

    init() {
        backgroundColor = lightBackgroundColor
        textColor = lightTextColor

        updateColors(getDefaultTheme())
    }

    func setDefaultTheme(theme: Theme.Name) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(theme.rawValue, forKey: defaultThemeKey)
        defaults.synchronize()

        updateColors(theme)
    }

    func getDefaultTheme() -> Theme.Name {
        let defaults = NSUserDefaults.standardUserDefaults()
        return Theme.Name(rawValue: defaults.integerForKey(defaultThemeKey))!
    }

    private func updateColors(theme: Theme.Name) {
        if theme == .Light {
            backgroundColor = lightBackgroundColor
            textColor = lightTextColor
        } else {
            backgroundColor = darkBackgroundColor
            textColor = darkTextColor
        }
    }
}

// MARK: - UIColor extensions

extension UIColor {
    static func themeDarkBackgroundColor() -> UIColor {
        return UIColor(red: 30.0/255.0, green: 55.0/255.0, blue: 117.0/255.0, alpha: 1.0)
    }

    static func themeDarkTextColor() -> UIColor {
        return UIColor.whiteColor()
    }

    static func themeLightBackgroundColor() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    }

    static func themeLightTextColor() -> UIColor {
        return UIColor(red: 10.0/255.0, green: 65.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    }

}
