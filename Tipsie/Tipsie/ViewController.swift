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
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var horizontalDividerView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var perPersonLabel: UILabel!
    @IBOutlet weak var tableHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var billAmountConstraintTop: NSLayoutConstraint!

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial state
        billAmountTextField.placeholder = getCurrencySymbol()
        tipAmountLabel.text = formatCurrency(0.00)
        totalAmountLabel.text = formatCurrency(0.00)
        Tips.setTipControlText(tipPercentSegmentedControl)
        tipPercentSegmentedControl.selectedSegmentIndex = Tips.getDefaultTipIndex()

        // Restore saved bill amount if there is one.
        if let billAmount = appDelegate.billAmount {
            billAmountTextField.text = "\(billAmount)"
            updateLables()
        }

        animateLayoutWithDuration(0.0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        applyTheme()
        tableView.reloadData()

        if Tips.getDefaultTipIndexChanged() {
            tipPercentSegmentedControl.selectedSegmentIndex = Tips.getDefaultTipIndex()
            Tips.setDefaultTipIndexChanged(false)
            updateLables()
        }

        billAmountTextField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // This ensures that the UIKeyboardAppearance.Dark does not get in a weird
        // state where the key colors change and numbers dissapear when the keys are
        // pressed. Not sure if this is a bug in iOS or I am doing something wrong.
        billAmountTextField.resignFirstResponder()
    }

    fileprivate func updateLables() {
        let tipPercent = Tips.double[tipPercentSegmentedControl.selectedSegmentIndex]

        if let billAmountText = billAmountTextField.text {
            let billAmount = (billAmountText as NSString).doubleValue
            let tipAmount = billAmount * tipPercent
            let totalAmount = billAmount + tipAmount
            tipAmountLabel.text = formatCurrency(tipAmount)
            totalAmountLabel.text = formatCurrency(totalAmount)
            tableView.reloadData()
        }
    }

    fileprivate func getCurrencySymbol() -> String {
        let local = Locale.current
        let currencySymbol = ((local as NSLocale).object(forKey: NSLocale.Key.currencySymbol) as! String)
        return currencySymbol
    }

    fileprivate func formatCurrency(_ number: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter.string(from: NSNumber(value: number))!
    }

    fileprivate func applyTheme() {
        let theme = Theme.sharedInstance
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = theme.backgroundColor
        navBar?.tintColor = theme.textColor
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: theme.textColor]
        navigationItem.rightBarButtonItem?.tintColor = theme.textColor
        view.backgroundColor = theme.backgroundColor
        billAmountTextField.textColor = theme.getDefaultTheme() == .dark ? theme.backgroundColor : theme.textColor
        billAmountTextField.layer.cornerRadius = 4
        billAmountTextField.keyboardAppearance = theme.getDefaultTheme() == .dark ? UIKeyboardAppearance.dark : UIKeyboardAppearance.light
        tipLabel.textColor = theme.textColor
        tipAmountLabel.textColor = theme.textColor
        horizontalDividerView.backgroundColor = theme.textColor
        totalLabel.textColor = theme.textColor
        totalAmountLabel.textColor = theme.textColor
        tipPercentSegmentedControl.tintColor = theme.textColor
        perPersonLabel.textColor = theme.textColor
        tableHeaderView.backgroundColor = theme.textColor
        tableView.backgroundColor = theme.backgroundColor
        tableView.separatorColor = theme.textColor
    }

    fileprivate func animateLayoutWithDuration(_ duration: Double) {
        let biilAmountHasText = billAmountTextField.hasText

        self.billAmountConstraintTop.constant = biilAmountHasText ? 13.0 : 130.0

        UIView.animate(withDuration: duration, animations: {
            self.tipLabel.alpha = biilAmountHasText ? 1.0 : 0.0
            self.tipAmountLabel.alpha = biilAmountHasText ? 1.0 : 0.0
            self.horizontalDividerView.alpha = biilAmountHasText ? 1.0 : 0.0
            self.totalLabel.alpha = biilAmountHasText ? 1.0 : 0.0
            self.totalAmountLabel.alpha = biilAmountHasText ? 1.0 : 0.0
            self.tipPercentSegmentedControl.alpha = biilAmountHasText ? 1.0 : 0.0
            self.perPersonLabel.alpha = biilAmountHasText ? 1.0 : 0.0
            self.tableHeaderView.alpha = biilAmountHasText ? 1.0 : 0.0
            self.tableView.alpha = biilAmountHasText ? 1.0 : 0.0
            self.view.layoutIfNeeded()
        })
    }

    @IBAction func onEditingChanged(_ sender: AnyObject) {
        animateLayoutWithDuration(0.8)
        updateLables()
        appDelegate.billAmount = billAmountTextField.text!
    }

    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

// MARK: - Table view data source and delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of per person amounts to display.
        return 19
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let theme = Theme.sharedInstance
        let cell = tableView.dequeueReusableCell(withIdentifier: "tipPerPersonCell") as! tipPerPersonCell

        // indexPath.row starts at 0, but we want to start the table at 2 people
        let numberOfPoeple = indexPath.row + 2
        var amountPerPerson = 0.00
        let tipPercent = Tips.double[tipPercentSegmentedControl.selectedSegmentIndex]

        if let billAmountText = billAmountTextField.text {
            let billAmount = (billAmountText as NSString).doubleValue
            let tipAmount = billAmount * tipPercent
            let totalAmount = billAmount + tipAmount
            amountPerPerson = totalAmount / Double(numberOfPoeple)
        }

        cell.userProfileImage.tintColor = theme.textColor
        cell.multiplyLabel.textColor = theme.textColor
        cell.numberOfPeopleLabel.text = "\(numberOfPoeple)"
        cell.numberOfPeopleLabel.textColor = theme.textColor
        cell.totalAmountLabel.text = formatCurrency(amountPerPerson)
        cell.totalAmountLabel.textColor = theme.textColor

        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let theme = Theme.sharedInstance
        cell.backgroundColor = theme.backgroundColor
        cell.tintColor = theme.textColor
    }
}

