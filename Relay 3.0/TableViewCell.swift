//
//  TableViewCell.swift
//  relay 2.0
//
//  Created by Chan Qing Hong on 9/5/17.
//  Copyright © 2017 Chan Qing Hong. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var MenuNames: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
