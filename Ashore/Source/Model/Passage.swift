//
//  Passage.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import Foundation

class Passage: NSObject {
    
    var title: String
    var passage: String
    var links: [String]

    override var description: String {
        return "\(title) — \(passage) — \(links)"
    }
    
    init(dictionary: [String:AnyObject]!) {
        title = dictionary["title"]! as! String
        passage = dictionary["passage"]! as! String
        links = dictionary["links"] as! [String]
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(passage, forKey: "passage")
        aCoder.encodeObject(links, forKey: "links")
    }
    
    init(coder aDecoder: NSCoder!) {
        title = aDecoder.decodeObjectForKey("title") as! String
        passage = aDecoder.decodeObjectForKey("passage") as! String
        links = aDecoder.decodeObjectForKey("links") as! [String]
    }

}