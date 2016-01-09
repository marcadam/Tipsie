//
//  Utils.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/8/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import Foundation

let billAmountKey = "BillAmount"
let billAmountSaveTimeKey = "BillAmountSaveTime"

func saveCurrentBillAmount(billAmount: String?) {
    if let billAmount = billAmount {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billAmount, forKey: billAmountKey)
        defaults.setObject(NSDate(), forKey: billAmountSaveTimeKey)
        defaults.synchronize()
    }
}

func getPreviousBillAmount() -> String? {
    let defaults = NSUserDefaults.standardUserDefaults()

    if let billAmount = defaults.stringForKey(billAmountKey), savedBillAmountSaveTime = (defaults.objectForKey(billAmountSaveTimeKey) as? NSDate) {
        let deltaTime = abs(savedBillAmountSaveTime.timeIntervalSinceNow)
        let maxSeconds = 60.0 * 5

        return deltaTime < maxSeconds ? billAmount : nil
    }

    return nil
}
