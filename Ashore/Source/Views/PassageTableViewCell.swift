//
//  PassageTableViewCell.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import UIKit

class PassageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var passageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
