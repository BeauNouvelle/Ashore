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
    
    lazy var paperSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "paper1", ofType: "wav")!)
    lazy var music = NSURL(fileURLWithPath: Bundle.main.path(forResource: "music", ofType: "caf")!)
    lazy var musicPlayer = AVAudioPlayer()
    lazy var paperPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        
        musicPlayer = try! AVAudioPlayer(contentsOf: music as URL)
        musicPlayer.prepareToPlay()
        musicPlayer.numberOfLoops = -1
        musicPlayer.play()
        
        paperPlayer = try! AVAudioPlayer(contentsOf: paperSound as URL)
        paperPlayer.volume = 0.50
        paperPlayer.prepareToPlay()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundView = UIView()
        tableView.backgroundView?.backgroundColor = UIColor.clear
        
//        storyManager.deleteSave()
        
        if let savedStory = storyManager.load() {
            headphoneImageView.removeFromSuperview()
            passages = savedStory
        } else {
            passages = [storyManager.passageWithTitle(title: "Reflect")] // name of first passage in story
            introHeadphoneAnimation()
        }
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(row: passages.count-1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: "ChoiceTableViewCell", bundle: nil), forCellReuseIdentifier: "ChoiceCell")
        tableView.register(UINib(nibName: "PassageTableViewCell", bundle: nil), forCellReuseIdentifier: "PassageCell")
    }
    
    func introHeadphoneAnimation() {
        tableView.isHidden = true
        tableView.alpha = 0.0
        headphoneImageView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            UIView.animate(withDuration: 1.0, animations: { () -> Void in
                self.headphoneImageView.alpha = 0.0
                self.tableView.isHidden = false
                self.tableView.alpha = 1.0
            }, completion: { (bool) -> Void in
                self.headphoneImageView.removeFromSuperview()
            })
        }

    }
    
    @objc func tappedChoice(sender: ChoiceButton) {
        let passageTitle = passages.last?.links[sender.tag]["passageTitle"]
        passages.append(storyManager.passageWithTitle(title: passageTitle!))
        storyManager.save(passages: passages)
        
        paperPlayer.play()
        
        let indexPath = IndexPath(row: passages.count-1, section: 0)
        
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // passage and choice
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return passages.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PassageCell") as! PassageTableViewCell
            let passage = passages[indexPath.row]
        
            cell.passageLabel?.text = passage.passage
            
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "ChoiceCell") as! ChoiceTableViewCell

        let lastPassage = passages.last
        
        if let count = lastPassage?.links.count, count > 1 {
            cell.button2.setTitle(lastPassage?.links[1]["displayText"], for: .normal)
            cell.button2.isHidden = false
            cell.button2.addTarget(self, action: #selector(tappedChoice(sender:)), for: .touchUpInside)
        } else {
            cell.button2.isHidden = true
        }
        
        cell.button1.setTitle(lastPassage?.links.first!["displayText"], for: .normal)
        cell.button1.addTarget(self, action: #selector(tappedChoice(sender:)), for: .touchUpInside)

        return cell
    }
}

