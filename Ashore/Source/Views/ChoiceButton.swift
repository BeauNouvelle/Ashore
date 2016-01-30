//
//  ChoiceButton.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import UIKit

class ChoiceButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0.0, 3.0)
        
        let backgroundImage = UIImage(named: "textile")
        backgroundColor = UIColor(patternImage: backgroundImage!)
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
