//
//  ListTableViewCell.swift
//  NYTimes
//
//  Created by Kunal Gaikwad on 15/01/20.
//  Copyright © 2020 Kunal. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellTitleLabel: UILabel!
       @IBOutlet weak var cellDesciptionLabel: UILabel!
       @IBOutlet weak var cellDateLabel: UILabel!
       @IBOutlet weak var cellImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
