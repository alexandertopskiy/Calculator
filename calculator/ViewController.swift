//
//  ViewController.swift
//  calculator
//
//  Created by Александр Васильевич on 24/03/2021.
//  Copyright © 2021 Александр Васильевич. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var displayResultLavel: UILabel!
    
    var stillTyping = false
    var dotIsPlaced = false
    var firstOperand: Double = 0
    var secondOperand: Double = 0
    var operationSign: String = ""
    
    
    var currentInput: Double {
        get {
            return Double(displayResultLavel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            
            if valueArray[1] == "0" {
                displayResultLavel.text = "\(valueArray[0])"
            } else {
                displayResultLavel.text = "\(newValue)"
            }
            stillTyping = false
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        let number = sender.currentTitle!
        if stillTyping {
            if displayResultLavel.text!.count < 20 {
                displayResultLavel.text = displayResultLavel.text! + number
            }
        } else {
            displayResultLavel.text = number
            stillTyping = true
        }
    }
    
    @IBAction func twoOperandsSignPressed(_ sender: UIButton) {
        operationSign = sender.currentTitle!
        firstOperand = currentInput
        stillTyping = false
        dotIsPlaced = false
    }
    
    func operateWithTwoOperand(operation: (Double,Double) -> Double) {
        currentInput = operation(firstOperand,secondOperand)
        firstOperand = currentInput
        stillTyping = false
    }
    
    @IBAction func equalitySignPressed(_ sender: UIButton) {
     
        if stillTyping {
            secondOperand = currentInput
        }
        
        dotIsPlaced = false
        
        switch operationSign {
        case "+":
            operateWithTwoOperand{$0 + $1}
        case "-":
            operateWithTwoOperand{$0 - $1}
        case "×":
            operateWithTwoOperand{$0 * $1}
        case "÷":
            operateWithTwoOperand{$0 / $1}
        default: break
        }
        
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        currentInput = 0
        displayResultLavel.text = "0"
        operationSign = ""
        stillTyping = false
        dotIsPlaced = false
    }
    
    @IBAction func plusOrMinusButtinPressed(_ sender: UIButton) {
        currentInput = -currentInput
    }
    
    @IBAction func percentageButtonPressed(_ sender: UIButton) {
        if firstOperand == 0 {
            currentInput = currentInput / 100
        } else {
            secondOperand = firstOperand * currentInput / 100
            currentInput = secondOperand //из комментов
        }
        stillTyping = false
        dotIsPlaced = false //из комментов
    }
    
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        if stillTyping && !dotIsPlaced {
            displayResultLavel.text = displayResultLavel.text! + "."
            dotIsPlaced = true
        } else if !stillTyping && !dotIsPlaced {
            displayResultLavel.text = "0."
            stillTyping = true
        }
    }
    
    @IBAction func squareRootButtonPressed(_ sender: UIButton) {
        currentInput = sqrt(currentInput)
    }
    
    
}

