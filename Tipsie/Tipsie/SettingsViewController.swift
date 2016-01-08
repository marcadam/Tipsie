//
//  SettingsViewController.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/7/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        Tips.setTipControlText(tipPercentSegmentedControl)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tipPercentSegmentedControl.selectedSegmentIndex = Tips.getDefaultTipIndex()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneWithSettings(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onDefaultTipValueChanged(sender: UISegmentedControl) {
        Tips.setDefaultTipIndex(tipPercentSegmentedControl.selectedSegmentIndex)
    }
}
