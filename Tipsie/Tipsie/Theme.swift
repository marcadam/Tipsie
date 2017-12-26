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
        case light, dark
    }

    fileprivate let darkBackgroundColor = UIColor.themeDarkBackgroundColor()
    fileprivate let darkTextColor = UIColor.themeDarkTextColor()

    fileprivate let lightBackgroundColor = UIColor.themeLightBackgroundColor()
    fileprivate let lightTextColor = UIColor.themeLightTextColor()

    var backgroundColor: UIColor
    var textColor: UIColor

    fileprivate let defaultThemeKey = "DefaultTheme"

    static let sharedInstance = Theme()

    init() {
        backgroundColor = lightBackgroundColor
        textColor = lightTextColor

        updateColors(getDefaultTheme())
    }

    func setDefaultTheme(_ theme: Theme.Name) {
        let defaults = UserDefaults.standard
        defaults.set(theme.rawValue, forKey: defaultThemeKey)
        defaults.synchronize()

        updateColors(theme)
    }

    func getDefaultTheme() -> Theme.Name {
        let defaults = UserDefaults.standard
        return Theme.Name(rawValue: defaults.integer(forKey: defaultThemeKey))!
    }

    fileprivate func updateColors(_ theme: Theme.Name) {
        if theme == .light {
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
        return UIColor.white
    }

    static func themeLightBackgroundColor() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 238.0/255.0, blue: 238.0/255.0, alpha: 1.0)
    }

    static func themeLightTextColor() -> UIColor {
        return UIColor(red: 10.0/255.0, green: 65.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    }

}
