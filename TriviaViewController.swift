//
//  TriviaViewController.swift
//  MP1_Deverett
//
//  Created by Sam Deverett on 5/23/20.
//  Copyright © 2020 Sam Deverett. All rights reserved.
//

import Foundation
import UIKit

class TriviaViewController: UIViewController {
    
    var PLAYING: Bool = false
    var personName: String!
    var names: Array<String>!
    var nameSelected: String!
    var score: Int = 0
    var timer = Timer()
    var currentStreak: Int = 0
    var longestStreak: Int = 0
    var lastThree: Array<String> = []
    
    // HELPFUL FUNCTIONS
    
    // Selects random member name
    func getRandomName() -> String {
        return Constants.names.randomElement()!
    }
    
    // Increments score, keeps track of streak, and updates history
    func gotItRight() {
        score += 1
        currentStreak += 1
        if currentStreak > longestStreak {
            longestStreak = currentStreak
        }
        updateHistory(last: "Right")
    }
    
    // Same as above
    func gotItWrong() {
        currentStreak = 0
        updateHistory(last: "Wrong")
    }
    
    // Updates history of responses
    func updateHistory(last: String) {
        if lastThree.count < 3 {
            lastThree.append(last)
        } else {
            lastThree.removeFirst()
            lastThree.append(last)
        }
    }
    
    // Disables all name buttons
    func disableButtons() {
        firstNameDisplay.isEnabled = false
        secondNameDisplay.isEnabled = false
        thirdNameDisplay.isEnabled = false
        fourthNameDisplay.isEnabled = false
    }
    
    // Enables all name buttons
    func enableButtons() {
        firstNameDisplay.isEnabled = true
        secondNameDisplay.isEnabled = true
        thirdNameDisplay.isEnabled = true
        fourthNameDisplay.isEnabled = true
    }
    
    @objc func timerAction(){
        self.viewDidLoad()
    }

    // START/STOP BUTTON
    
    @IBOutlet weak var gameStartName: UIButton!
    
    @IBAction func gameStart(_ sender: Any) {
        timer.invalidate()
        if PLAYING {
            PLAYING = false
        } else {
            PLAYING = true
        }
        self.viewDidLoad()
    }
    
    // ACTIONS PER ANSWER
    
    @IBOutlet weak var personImg: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var firstNameDisplay: UIButton!
    
    @IBOutlet weak var secondNameDisplay: UIButton!
    
    @IBOutlet weak var thirdNameDisplay: UIButton!
    
    @IBOutlet weak var fourthNameDisplay: UIButton!
    
    @IBAction func firstNamePressed(_ sender: Any) {
        disableButtons()
        timer.invalidate()
        if firstNameDisplay.titleLabel!.text == personName {
            firstNameDisplay.setTitleColor(.green, for: UIControl.State.normal)
            gotItRight()
        } else {
            gotItWrong()
            firstNameDisplay.setTitleColor(.red, for: UIControl.State.normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.viewDidLoad()
        }
    }
    
    @IBAction func secondNamePressed(_ sender: Any) {
        disableButtons()
        timer.invalidate()
        if secondNameDisplay.titleLabel!.text == personName {
            secondNameDisplay.setTitleColor(.green, for: UIControl.State.normal)
            gotItRight()
        } else {
            gotItWrong()
            secondNameDisplay.setTitleColor(.red, for: UIControl.State.normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.viewDidLoad()
        }
    }
    
    @IBAction func thirdNamePressed(_ sender: Any) {
        disableButtons()
        timer.invalidate()
        if thirdNameDisplay.titleLabel!.text == personName {
            thirdNameDisplay.setTitleColor(.green, for: UIControl.State.normal)
            gotItRight()
        } else {
            gotItWrong()
            thirdNameDisplay.setTitleColor(.red, for: UIControl.State.normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.viewDidLoad()
        }
    }
    
    @IBAction func fourthNamePressed(_ sender: Any) {
        disableButtons()
        timer.invalidate()
        if fourthNameDisplay.titleLabel!.text == personName {
            fourthNameDisplay.setTitleColor(.green, for: UIControl.State.normal)
            gotItRight()
        } else {
            gotItWrong()
            fourthNameDisplay.setTitleColor(.red, for: UIControl.State.normal)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.viewDidLoad()
        }
    }
    
    // STATS BUTTON + SEGUE
    
    @objc func statsAction() {
        PLAYING = false
        self.viewDidLoad()
        self.performSegue(withIdentifier: "toStatsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! StatsViewController
        destinationVC.longestStreakInt = longestStreak
        destinationVC.history = lastThree
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set stats button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stats", style: .plain, target: self, action: #selector(statsAction))
        if PLAYING {
            enableButtons()
            // Pick random name
            personName = getRandomName()
            // Generate picture of random name
            personImg.image = Constants.getImageFor(name: personName)
            // Generate other random names
            var allNames = Constants.names
            allNames.remove(at: allNames.firstIndex(of: personName)!)
            let wrongNames = allNames.shuffled()[..<3]
            names = [personName] + wrongNames
            names.shuffle()
            // Set colors
            firstNameDisplay.setTitleColor(.blue, for: UIControl.State.normal)
            secondNameDisplay.setTitleColor(.blue, for: UIControl.State.normal)
            thirdNameDisplay.setTitleColor(.blue, for: UIControl.State.normal)
            fourthNameDisplay.setTitleColor(.blue, for: UIControl.State.normal)
            firstNameDisplay.backgroundColor = UIColor.lightGray
            secondNameDisplay.backgroundColor = UIColor.lightGray
            thirdNameDisplay.backgroundColor = UIColor.lightGray
            fourthNameDisplay.backgroundColor = UIColor.lightGray
            scoreLabel.textColor = UIColor.black
            // Set names
            firstNameDisplay.setTitle(names[0], for: UIControl.State.normal)
            secondNameDisplay.setTitle(names[1], for: UIControl.State.normal)
            thirdNameDisplay.setTitle(names[2], for: UIControl.State.normal)
            fourthNameDisplay.setTitle(names[3], for: UIControl.State.normal)
            gameStartName.setTitle("Stop", for: UIControl.State.normal)
            // Set score
            scoreLabel.text = "Score \(String(score))"
            // Start timer
            timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
        } else {
            // Only show "start" button
            gameStartName.setTitle("Start", for: UIControl.State.normal)
            personImg.image = UIImage(named: "white")
            firstNameDisplay.setTitleColor(.white, for: UIControl.State.normal)
            secondNameDisplay.setTitleColor(.white, for: UIControl.State.normal)
            thirdNameDisplay.setTitleColor(.white, for: UIControl.State.normal)
            fourthNameDisplay.setTitleColor(.white, for: UIControl.State.normal)
            firstNameDisplay.backgroundColor = UIColor.white
            secondNameDisplay.backgroundColor = UIColor.white
            thirdNameDisplay.backgroundColor = UIColor.white
            fourthNameDisplay.backgroundColor = UIColor.white
            scoreLabel.textColor = UIColor.white
        }
    }
    
}
