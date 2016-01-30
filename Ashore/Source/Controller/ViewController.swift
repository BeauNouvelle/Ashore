//
//  ViewController.swift
//  Ashore
//
//  Created by Beau Young on 29/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let storyManager = StoryManager()
    
    var passages = [Passage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        let passage1 = Passage(dictionary: ["title":"Day 1", "passage":"some story text goes here", "links":["link 1", "link 2"]])
        let passage2 = Passage(dictionary: ["title":"Day 2", "passage":"sjkasdfoiweoic", "links":["link 1", "link 2"]])
        print(passage1.description)
        
        storyManager.save([passage1, passage2])
        
        let allPassags = storyManager.load()
        print(allPassags)
        
        if let savedStory = storyManager.load() {
            passages = savedStory
        } else {
            // we start new story.
        }
        
    }
    
    func registerCells() {
        tableView.registerNib(UINib(nibName: "ChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceCell")
        tableView.registerNib(UINib(nibName: "PassageTableViewCell", bundle: nil), forCellReuseIdentifier: "PassageCell")
    }
    
}

extension ViewController: UITableViewDataSource {
 
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2 // passage and choice
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return passages.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("PassageCell") as! PassageTableViewCell
            
            let passage = passages[indexPath.row]
            cell.textLabel?.text = passage.title
            cell.detailTextLabel?.text = passage.passage
            
            return cell
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("ChoiceCell") as! ChoiceTableViewCell
        // choice cell
        let lastPassage = passages.last
        cell.textLabel?.text = lastPassage?.links.first

        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
}

