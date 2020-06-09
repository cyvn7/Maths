//
//  Gra.swift
//  Maths
//
//  Created by Maciej Przybylski on 14/08/2019.
//  Copyright © 2019 Maciej Przybylski. All rights reserved.
//

import UIKit
import ChameleonFramework

class ActualGame: UIViewController {
    
    //MARK: Basic objects
    var mode : Character = "*"
    var btnBgColor : String = ""
    var resultArray = [Int]() //array of user's inputs
    var goodAnswers = 0
    //<font size='+8' font face='helvetica'
    var scoreStr = ""
    var isNextLvl = false
    var lvl = 1.0
    var time = 0.0

    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultField: UITextField!
    @IBOutlet weak var btnBg: UIButton!
    
    override func viewDidLoad() {
        
        switch mode {
        case "*",":":
            time = 6.0
        default:
            time = 31.0
        }
        
        randomize()
        
        switch mode {
        case ":":
            XLabel.text! = String(x[0] * y[0])
            YLabel.text! = String(y[0])
        default:
            XLabel.text! = String(x[0])
            YLabel.text! = String(y[0])
        }
        SymbolLabel.text! = String(mode)
        
        timerGo()
        startTimer()
        
        super.viewDidLoad()
        btnBg.backgroundColor = UIColor(hexString: btnBgColor)
        
        resultField.becomeFirstResponder()
    }
    
    //MARK: Timer stuff
    
    var timer = Timer()
    
    
    
    func startTimer(){
        //print("Timer started")
         timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerGo), userInfo: nil, repeats: true)
    }
    
    func resetTimer(){
        timer.invalidate()
        startTimer()
    }
    
    @objc func timerGo() {
        time -= 1
        if time <= 0 {
//            time = 5
//            resetTimer()
            nextOperation()
        }
        timeLabel.text = "Czas: \(Int(time))"
        if indexOfOperations > 48 {
            print("tick")
        }
    }
    
    //MARK: Randomizing stuff
    
    var x = [Int]() //array of randomized first numbers
    var y = [Int]() //array of randomized second numbers
    var operations = [String]()
    
    var xForNow = Int()
    var yForNow = Int()
    var operationForNow = String()
    var extra = 25
    var maxXperLevel = 25
    
    func randomize() {
        
        switch mode {
        case "+","-":
            maxXperLevel = 25
            extra = 25
        default:
            maxXperLevel = 4
            extra = 2
        }
        for i in 0...49 { //i for index
            
            if i == 4 || i == 14 || i == 29 {
                maxXperLevel += extra
            }
            
            repeat {
                switch mode {
                case "*", ":" :
                    xForNow = Int.random(in: 2 ..< maxXperLevel)
                    yForNow = Int.random(in: 2 ..< 10)
                case "+" :
                    xForNow = Int.random(in: 8 ..< maxXperLevel)
                    yForNow = Int.random(in: 2 ..< 100)
                case "-" :
                    xForNow = Int.random(in: 8 ..< maxXperLevel)
                    yForNow = Int.random(in: 1 ..< xForNow )
                default:
                    print("yay")
                }
                operationForNow = "\(xForNow) n \(yForNow)"
            } while operations.contains(operationForNow)
            x.append(xForNow)
            y.append(yForNow)
            operations.append(operationForNow)
            print("\(x[i]) * \(y[i])")
        }
        
    
    }
    
    //MARK: Running game stuff
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var XLabel: UILabel!
    @IBOutlet weak var SymbolLabel: UILabel!
    @IBOutlet weak var YLabel: UILabel!
    
    var indexOfOperations = 0
    
    
    @IBAction func nextBtn(_ sender: Any) {
//        if isNextLvl == true {
//            startTimer()
//            isNextLvl = false
//            //indexOfOperations -= 1
//        }
//        else {
//            if let result = Int(resultField.text!) {
//                resultArray.append(result)
//            }
//            else {
//                resultArray.append(0)
//            }
//        }
            nextOperation()
        
    }
    
    func nextOperation() {
        if isNextLvl == true {
            startTimer()
            isNextLvl = false
            //indexOfOperations -= 1
        }
        else {
            if let result = Int(resultField.text!) {
                resultArray.append(result)
            }
            else {
                resultArray.append(0)
            }
        }
        //to shorten code
        let xx = x[indexOfOperations]
        let yy = y[indexOfOperations]
        
        //musisz to przeniść bo między levelami wpisuje puste pole!!!!
        
        let res = resultArray[indexOfOperations]
        
        switch mode {
        case "*":
            if res == (xx * yy) {
                scoreLabel.text! = "Dobrze!"
                scoreLabel.backgroundColor = UIColor.flatMint()
                goodAnswers += 1
                scoreStr += "\(xx) * \(yy) = \(res)<br>"
            }
            else {
                scoreLabel.text! = "Źle!"
                scoreLabel.backgroundColor = UIColor.flatRed()
                scoreStr += "\(xx) * \(yy) = \(res) (ŹLE: \(xx * yy))<br>"
            }
        case ":" :
            if res == (xx) {
                scoreLabel.text! = "Dobrze!"
                scoreLabel.backgroundColor = UIColor.flatMint()
                goodAnswers += 1
                scoreStr += "\(xx * yy) : \(yy) = \(res)<br>"
            }
            else {
                scoreLabel.text! = "Źle!"
                scoreLabel.backgroundColor = UIColor.flatRed()
                scoreStr += "\(xx * yy) : \(yy) = \(res) (ŹLE: \(xx))<br>"
            }
        case "+":
            if res == (xx + yy) {
                scoreLabel.text! = "Dobrze!"
                scoreLabel.backgroundColor = UIColor.flatMint()
                goodAnswers += 1
                scoreStr += "\(xx) + \(yy) = \(res)<br>"
            }
            else {
                scoreLabel.text! = "Źle!"
                scoreLabel.backgroundColor = UIColor.flatRed()
                scoreStr += "\(xx) + \(yy) = \(res) (ŹLE: \(xx + yy))<br>"
            }
        case "-":
            if res == (xx - yy) {
                scoreLabel.text! = "Dobrze!"
                scoreLabel.backgroundColor = UIColor.flatMint()
                scoreStr += "\(xx) - \(yy) = \(res)<br>"
                goodAnswers += 1
            }
            else {
                scoreLabel.text! = "Źle!"
                scoreLabel.backgroundColor = UIColor.flatRed()
                scoreStr += "\(xx) - \(yy) = \(res) (ŹLE: \(xx - yy))<br>"
            }
        default:
            print("yay!")
        }
        
        if indexOfOperations == 49 {
            self.scoreStr += "</font>"
            timer.invalidate()
            let alert = UIAlertController(title: "Koniec gry!", message: "Twoja ocena to \(mark()), zobacz swoje wyniki!", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Oki", style: .default, handler: { action in
                    self.performSegue(withIdentifier: "showScore", sender: self)
                }))
            self.present(alert, animated: true)
            
        }
        else if ((indexOfOperations == 4 && lvl == 1) || (indexOfOperations == 14 && lvl == 2) || (indexOfOperations == 29 && lvl == 3)) && isNextLvl == false {
            timer.invalidate()
            lvl += 1
            lvlLabel.text! = "Poziom: \(Int(lvl))"
            isNextLvl = true
            XLabel.text! = ""
            YLabel.text! = ""
        }
        else {
            indexOfOperations += 1
            let xx = x[indexOfOperations]
            let yy = y[indexOfOperations]
            resetTimer()
            resultField.text! = ""
            switch mode {
            case "*",":":
                time = 5 * lvl
            default:
                time = 20 + 10 * lvl
                
            }
            timeLabel.text = "Czas: \(Int(time))"
            switch mode {
            case ":":
                XLabel.text! = String(xx * yy)
                YLabel.text! = String(yy)
            default:
                XLabel.text! = String(xx)
                YLabel.text! = String(yy)
            }
        }
        
        
        
        
    }
    
    func mark() -> Int {
        let percent = 2 * goodAnswers
//        if percent == 0 {
//            percent += 1
//        }
        switch percent {
        case 95...100:
            return 6
        case 90...94:
            return 5
        case 71...89:
            return 4
        case 51...70:
            return 3
        case 30...50:
            return 2
        default:
            return 1
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationFVC = segue.destination as! Score
        timer = Timer()
        if segue.identifier == "showScore" {
//            if traitCollection.userInterfaceStyle == .dark {
//                 realScoreStr += "font color='white'> <body style='background-color:black;'>" + scoreStr
//            }
//            else {
//                 realScoreStr += "font color='black'> <body style='background-color:white;'>" + scoreStr
//            }
            destinationFVC.textFile = scoreStr
            destinationFVC.modalPresentationStyle = .overFullScreen
        }
        }
}
