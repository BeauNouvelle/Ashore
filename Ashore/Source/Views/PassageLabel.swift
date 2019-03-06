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
    
    @IBInspectable var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10) {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: edgeInsets)
        var rect  = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        
        rect.origin.x -= edgeInsets.left
        rect.origin.y -= edgeInsets.top
        rect.size.width  += (edgeInsets.left + edgeInsets.right);
        rect.size.height += (edgeInsets.top + edgeInsets.bottom);
        
        return rect
    }
    
    override func drawText(in rect: CGRect) {
        let insetRect = rect.inset(by: edgeInsets)
        super.drawText(in: insetRect)
    }
    
}
