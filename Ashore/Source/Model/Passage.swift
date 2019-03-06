//
//  Passage.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import Foundation

struct Passage {
    
    var passage: String
    var links: [[String:String]]

    func description() -> String {
        return "\(passage) — \(links)"
    }
    
    init(dictionary: [String:AnyObject]!) {
        passage = dictionary["passage"]! as! String
        links = dictionary["links"] as! [[String:String]]
    }
    
}

extension Passage {
    
    func encode() -> Data {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(passage, forKey: "passage")
        archiver.encode(links, forKey: "links")
        archiver.finishEncoding()
        
        return data as Data
    }
    
    init?(data: Data) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        defer {
            unarchiver.finishDecoding()
        }
        
        guard let passage = unarchiver.decodeObject(forKey: "passage") as? String else { return nil }
        guard let links = unarchiver.decodeObject(forKey: "links") as? [[String:String]] else { return nil }
        
        self.passage = passage
        self.links = links
    }
    
 }
