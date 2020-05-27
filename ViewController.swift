//
//  ViewController.swift
//  MP1_Deverett
//
//  Created by Sam Deverett on 5/23/20.
//  Copyright © 2020 Sam Deverett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "toTriviaVC", sender: self)
    }
    
}

