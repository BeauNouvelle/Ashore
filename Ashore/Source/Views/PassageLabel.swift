//
//  PassageLabel.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import UIKit

@IBDesignable

class PassageLabel: UILabel {
    
    @IBInspectable var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5) {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowColor = UIColor.blackColor().CGColor
        layer.shadowOffset = CGSizeMake(0.0, 3.0)
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        var rect = super.textRectForBounds(UIEdgeInsetsInsetRect(bounds, edgeInsets), limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= edgeInsets.left
        rect.origin.y -= edgeInsets.top
        rect.size.width  += (edgeInsets.left + edgeInsets.right);
        rect.size.height += (edgeInsets.top + edgeInsets.bottom);
        
        return rect
    }
    
    override func drawTextInRect(rect: CGRect) {
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
    
    

}
