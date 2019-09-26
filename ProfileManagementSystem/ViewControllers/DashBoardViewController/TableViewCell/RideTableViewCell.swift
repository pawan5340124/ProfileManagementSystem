//
//  RideTableViewCell.swift
//  ProfileManagementSystem
//
//  Created by Pawan Kumar on 22/09/19.
//  Copyright © 2019 Pawan Kumar. All rights reserved.
//

import UIKit

class RideTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblSpeed: UILabel!
    @IBOutlet weak var lblEndingPoint: UILabel!
    @IBOutlet weak var lblStartingPoint: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
