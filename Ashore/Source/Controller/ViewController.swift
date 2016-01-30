//
//  ViewController.swift
//  Ashore
//
//  Created by Beau Young on 29/01/2016.
//  Copyright © 2016 Beau Nouvelle. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var storyManager = StoryManager()
    lazy var passages = [Passage]()
    
    lazy var paperSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("paper1", ofType: "wav")!)
    lazy var audioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        audioPlayer = try! AVAudioPlayer(contentsOfURL: paperSound)
        audioPlayer.prepareToPlay()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundView = UIView()
        tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        
        storyManager.deleteSave()
        
        if let savedStory = storyManager.load() {
            passages = savedStory
        } else {
            passages = [storyManager.passageWithTitle("leaving the island")] // name of first passage in story
        }
        tableView.reloadData()
    }
    
    func registerCells() {
        tableView.registerNib(UINib(nibName: "ChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceCell")
        tableView.registerNib(UINib(nibName: "PassageTableViewCell", bundle: nil), forCellReuseIdentifier: "PassageCell")
    }
    
    func tappedChoice(sender: ChoiceButton) {
        
        let passageTitle = passages.last?.links[sender.tag]["passageTitle"]
        passages.append(storyManager.passageWithTitle(passageTitle!))
        
        audioPlayer.play()
        
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: passages.count-1, inSection: 0)], withRowAnimation: .Fade)
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: passages.count-1, inSection: 0), atScrollPosition: .Top, animated: true)
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
        
            cell.passageLabel?.text = passage.passage
            
            return cell
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("ChoiceCell") as! ChoiceTableViewCell

        let lastPassage = passages.last
        
        if lastPassage?.links.count > 1 {
            cell.button2.setTitle(lastPassage?.links[1]["displayText"], forState: .Normal)
            cell.button2.hidden = false
            cell.button2.addTarget(self, action: "tappedChoice:", forControlEvents: .TouchUpInside)
            // set target here
        } else {
            cell.button2.hidden = true
            // set target here
        }
        
        cell.button1.setTitle(lastPassage?.links.first!["displayText"], forState: .Normal)
        cell.button1.addTarget(self, action: "tappedChoice:", forControlEvents: .TouchUpInside)

        return cell
    }
}

