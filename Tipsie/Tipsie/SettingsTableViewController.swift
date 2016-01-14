//
//  SettingsTableViewController.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/8/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var defaultTipLabel: UILabel!
    @IBOutlet weak var tipPercentSegmentedControl: UISegmentedControl!
    @IBOutlet weak var darkThemeLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        Tips.setTipControlText(tipPercentSegmentedControl)
        setThemeSwitchState()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        tipPercentSegmentedControl.selectedSegmentIndex = Tips.getDefaultTipIndex()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func applyTheme() {
        let theme = Theme.sharedInstance
        let navBar = navigationController?.navigationBar
        navBar?.barTintColor = theme.backgroundColor
        navBar?.tintColor = theme.textColor
        navBar?.titleTextAttributes = [NSForegroundColorAttributeName: theme.textColor]
        navigationItem.rightBarButtonItem?.tintColor = theme.textColor
        view.backgroundColor = theme.backgroundColor
        defaultTipLabel.textColor = theme.textColor
        tipPercentSegmentedControl.tintColor = theme.textColor
        darkThemeLabel.textColor = theme.textColor
        themeSwitch.thumbTintColor = theme.textColor
        themeSwitch.tintColor = theme.textColor
        tableView.separatorColor = theme.textColor
    }

    private func setThemeSwitchState() {
        let theme = Theme.sharedInstance
        themeSwitch.on = theme.getDefaultTheme() == .Dark ? true : false
    }

    @IBAction func doneWithSettings(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onDefaultTipValueChanged(sender: UISegmentedControl) {
        Tips.setDefaultTipIndex(tipPercentSegmentedControl.selectedSegmentIndex)
    }

    @IBAction func onSwitchChange(sender: UISwitch) {
        let theme = Theme.sharedInstance

        if sender.on {
            theme.setDefaultTheme(.Dark)
        } else {
            theme.setDefaultTheme(.Light)
        }

        applyTheme()
        tableView.reloadData()
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

    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let theme = Theme.sharedInstance
        cell.backgroundColor = theme.backgroundColor
        cell.tintColor = theme.textColor
    }

    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let theme = Theme.sharedInstance
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.contentView.backgroundColor = theme.backgroundColor
        header.textLabel!.textColor = theme.textColor
    }
}
