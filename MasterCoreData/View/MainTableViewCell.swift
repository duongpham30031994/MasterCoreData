//
//  MainTableViewCell.swift
//  MasterCoreData
//
//  Created by Apple on 5/14/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var lb_nameProduct: UILabel!
    @IBOutlet weak var img_Product: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
