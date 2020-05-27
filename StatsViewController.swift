//
//  StatsViewController.swift
//  MP1_Deverett
//
//  Created by Sam Deverett on 5/26/20.
//  Copyright © 2020 Sam Deverett. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    
    var longestStreakInt: Int!
    var history: Array<String>!
    
    @IBOutlet weak var longestStreakLabel: UILabel!
    
    @IBOutlet weak var lastThreeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longestStreakLabel.text = "Longest Streak: \(longestStreakInt!)"
        if history.count == 0 {
            lastThreeLabel.textColor = UIColor.white
        } else {
            lastThreeLabel.text = "History: \(history[0])"
            for i in 1..<history.count {
                lastThreeLabel.text! += ", \(history[i])"
            }
        }
    }

}
