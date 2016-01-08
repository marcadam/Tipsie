//
//  SettingsTableViewController.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/8/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

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

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

}
