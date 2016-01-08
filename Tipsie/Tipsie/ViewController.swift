//
//  ViewController.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/7/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial state
        billAmountTextField.placeholder = getCurrencySymbol()
        tipAmountLabel.text = formatCurrency(0.00)
        totalAmountLabel.text = formatCurrency(0.00)
        Tips.setTipControlText(tipPercentSegmentedControl)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        billAmountTextField.becomeFirstResponder()

        if Tips.getDefaultTipIndexChanged() {
            tipPercentSegmentedControl.selectedSegmentIndex = Tips.getDefaultTipIndex()
            Tips.setDefaultTipIndexChanged(false)
            updateLables()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func updateLables() {
        let tipPercent = Tips.double[tipPercentSegmentedControl.selectedSegmentIndex]

        if let billAmountText = billAmountTextField.text {
            let billAmount = (billAmountText as NSString).doubleValue
            let tipAmount = billAmount * tipPercent
            let totalAmount = billAmount + tipAmount
            tipAmountLabel.text = formatCurrency(tipAmount)
            totalAmountLabel.text = formatCurrency(totalAmount)
        }
    }

    private func getCurrencySymbol() -> String {
        let local = NSLocale.currentLocale()
        let currencySymbol = (local.objectForKey(NSLocaleCurrencySymbol) as! String)
        return currencySymbol
    }

    private func formatCurrency(number: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(number)!
    }

    @IBAction func onEditingChanged(sender: AnyObject) {
        updateLables()
    }

    @IBAction func onTap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

