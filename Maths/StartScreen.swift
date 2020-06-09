//
//  ViewController.swift
//  Maths
//
//  Created by Maciej Przybylski on 14/08/2019.
//  Copyright © 2019 Maciej Przybylski. All rights reserved.
//

import UIKit

class StartScreen: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationFVC = segue.destination as! ActualGame
        destinationFVC.modalPresentationStyle = .overFullScreen
        switch segue.identifier {
        case "plus":
            destinationFVC.mode = "+"
            destinationFVC.btnBgColor = "52FF7B"
        case "minus":
            destinationFVC.mode = "-"
            destinationFVC.btnBgColor = "5200BC"
        case "multiply":
            destinationFVC.mode = "*"
            destinationFVC.btnBgColor = "DE0047"
        case "divide":
            destinationFVC.mode = ":"
            destinationFVC.btnBgColor = "DA6C00"
        default:
            print("yay!")
        }
    }

}

