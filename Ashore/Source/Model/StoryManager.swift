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
    
    lazy var story: [String:AnyObject] = {
        let path = Bundle.main.path(forResource: "Story", ofType: "plist")
        let dict = NSDictionary(contentsOfFile: path!) as! [String:AnyObject]
        return dict
    }()
    
    func passageWithTitle(title: String) -> Passage {
        let passageDict = story[title] as! [String:AnyObject]
        return Passage(dictionary: passageDict)
    }
    
    func load() -> [Passage]? {
        if let data = UserDefaults.standard.object(forKey: "passages") as? [Data] {
            let passages = data.compactMap { Passage(data: $0) }
            return passages
        }
        return nil
    }
    
    func save(passages: [Passage]) {
        let encodedPassages = passages.map { $0.encode() }
        UserDefaults.standard.set(encodedPassages, forKey: "passages")
    }
    
    func deleteSave() {
        UserDefaults.standard.removeObject(forKey: "passages")
    }
    
}
