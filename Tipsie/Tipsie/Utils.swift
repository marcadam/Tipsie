//
//  Utils.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/8/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import Foundation

func saveCurrentBillAmount(billAmount: String?) {
    if let billAmount = billAmount {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billAmount, forKey: "BillAmount")
        defaults.setObject(NSDate(), forKey: "BillAmountSaveTime")
        defaults.synchronize()
    }
}

func getPreviousBillAmount() -> String? {
    let defaults = NSUserDefaults.standardUserDefaults()
    let billAmount = defaults.stringForKey("BillAmount")
    let savedBillAmountSaveTime = (defaults.objectForKey("BillAmountSaveTime") as! NSDate)
    let deltaTime = abs(savedBillAmountSaveTime.timeIntervalSinceNow)
    let maxSeconds = 60.0 * 5

    return deltaTime < maxSeconds ? billAmount : nil
}
