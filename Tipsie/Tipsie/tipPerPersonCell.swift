//
//  tipPerPersonCell.swift
//  Tipsie
//
//  Created by Marc Anderson on 1/8/16.
//  Copyright © 2016 Marc Anderson. All rights reserved.
//

import UIKit

class tipPerPersonCell: UITableViewCell {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var multiplyLabel: UILabel!
    @IBOutlet weak var numberOfPeopleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        // This allows us to dynamically change the color of the user profile image to match theme.
        var image = UIImage(named: "UserProfile")!
        image = image.withRenderingMode(.alwaysTemplate)
        userProfileImage.image = image
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
