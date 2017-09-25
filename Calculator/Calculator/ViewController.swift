//
//  ViewController.swift
//  Calculator
//
//  Created by Ashish Kumar Sonkar on 12/08/17.
//  Copyright © 2017 Ashish Kumar Sonkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    var userIsInMiddleOfTyping = false
    @IBAction func numberButtonPressed(_ sender: UIButton) {
        
        let digit = sender.currentTitle!
        var textCurrentlyInDisplay = display.text!
        if userIsInMiddleOfTyping{
            textCurrentlyInDisplay = textCurrentlyInDisplay + digit
            display.text = textCurrentlyInDisplay
            
        }
        else{
            display.text = digit
            userIsInMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
        
    }
    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInMiddleOfTyping{
            brain.setOperand(displayValue)
            userIsInMiddleOfTyping = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {
            displayValue  = result
        }
    }
    
    
    
}

