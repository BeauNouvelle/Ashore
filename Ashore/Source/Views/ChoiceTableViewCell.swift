//
//  ChoiceTableViewCell.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import UIKit

class ChoiceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        button1.setTitle("", for: .normal)
        button2.setTitle("", for: .normal)
    }
    
}
