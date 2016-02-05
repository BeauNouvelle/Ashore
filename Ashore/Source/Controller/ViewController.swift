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
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var headphoneImageView: UIImageView!
    lazy var storyManager = StoryManager()
    lazy var passages = [Passage]()
    
    lazy var paperSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("paper1", ofType: "wav")!)
    lazy var music = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: "caf")!)
    lazy var musicPlayer = AVAudioPlayer()
    lazy var paperPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        musicPlayer = try! AVAudioPlayer(contentsOfURL: music)
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
        
        paperPlayer = try! AVAudioPlayer(contentsOfURL: paperSound)
        paperPlayer.volume = 0.50
        paperPlayer.prepareToPlay()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundView = UIView()
        tableView.backgroundView?.backgroundColor = UIColor.clearColor()
        
//        storyManager.deleteSave()
        
        if let savedStory = storyManager.load() {
            headphoneImageView.removeFromSuperview()
            passages = savedStory
        } else {
            passages = [storyManager.passageWithTitle("Reflect")] // name of first passage in story
            introHeadphoneAnimation()
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: passages.count-1, inSection: 0), atScrollPosition: .Top, animated: false)
    }
    
    func registerCells() {
        tableView.registerNib(UINib(nibName: "ChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceCell")
        tableView.registerNib(UINib(nibName: "PassageTableViewCell", bundle: nil), forCellReuseIdentifier: "PassageCell")
    }
    
    func introHeadphoneAnimation() {
        tableView.hidden = true
        tableView.alpha = 0.0
        headphoneImageView.hidden = false
        
        let delayInSeconds = 4
        
        let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds) * Int64(NSEC_PER_SEC))
        dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
            UIView.animateWithDuration(1.0, animations: { () -> Void in
                self.headphoneImageView.alpha = 0.0
                self.tableView.hidden = false
                self.tableView.alpha = 1.0
                }, completion: { (bool) -> Void in
                    self.headphoneImageView.removeFromSuperview()
            })
        })
    }
    
    func tappedChoice(sender: ChoiceButton) {
        
        let passageTitle = passages.last?.links[sender.tag]["passageTitle"]
        passages.append(storyManager.passageWithTitle(passageTitle!))
        storyManager.save(passages)
        
        paperPlayer.play()
        
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

