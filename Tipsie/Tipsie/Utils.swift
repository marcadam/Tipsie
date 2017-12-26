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

func saveCurrentBillAmount(_ billAmount: String?) {
    if let billAmount = billAmount {
        let defaults = UserDefaults.standard
        defaults.set(billAmount, forKey: billAmountKey)
        defaults.set(Date(), forKey: billAmountSaveTimeKey)
        defaults.synchronize()
    }
}

func getPreviousBillAmount() -> String? {
    let defaults = UserDefaults.standard

    if let billAmount = defaults.string(forKey: billAmountKey), let savedBillAmountSaveTime = (defaults.object(forKey: billAmountSaveTimeKey) as? Date) {
        let deltaTime = abs(savedBillAmountSaveTime.timeIntervalSinceNow)
        let maxSeconds = 60.0 * 5

        return deltaTime < maxSeconds ? billAmount : nil
    }

    return nil
}
