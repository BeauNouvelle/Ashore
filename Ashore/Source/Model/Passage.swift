//
//  Passage.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import Foundation

class Passage: NSObject {
    
    var passage: String
    var links: [[String:String]]

    override var description: String {
        return "\(passage) — \(links)"
    }
    
    init(dictionary: [String:AnyObject]!) {
        passage = dictionary["passage"]! as! String
        links = dictionary["links"] as! [[String:String]]
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(passage, forKey: "passage")
        aCoder.encodeObject(links, forKey: "links")
    }
    
    init(coder aDecoder: NSCoder!) {
        passage = aDecoder.decodeObjectForKey("passage") as! String
        links = aDecoder.decodeObjectForKey("links") as! [[String:String]]
    }

}