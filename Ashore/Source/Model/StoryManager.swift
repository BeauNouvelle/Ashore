//
//  TextParser.swift
//  Ashore
//
//  Created by Beau Young on 30/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import Foundation
import UIKit

class StoryManager {
    
    func load() -> [Passage]? {
        if let data = NSUserDefaults.standardUserDefaults().objectForKey("passages") as? NSData {
            let passages = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Passage]
            return passages
        }
        return nil
    }
    
    func save(passages: [Passage]) {
        let data = NSKeyedArchiver.archivedDataWithRootObject(passages)
        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "passages")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
}