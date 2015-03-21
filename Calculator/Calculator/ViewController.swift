//
//  ViewController.swift
//  Calculator
//
//  Created by Hongzhi shi on 15/2/16.
//  Copyright (c) 2015年 Hongzhi shi. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var history: UILabel!
    var userIsInTheMiddleOfTypingANumber = false
    
    var brain = CalculatorBrain()

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        } else {
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func appendDot() {
        let index = display.text!.rangeOfString(".")
        if (userIsInTheMiddleOfTypingANumber && index == nil) {
            display.text = display.text! + "."
        }
    }
    
    @IBAction func enterPi() {
        displayValue = M_PI
        enter()
    }
    
    @IBAction func operate(sender: UIButton) {
        if userIsInTheMiddleOfTypingANumber {
            enter()
        }
        if let operation = sender.currentTitle {
            let (result, opStack) = brain.performOperation(operation)
            if (result != nil) {
                displayValue = result!
            } else {
                displayValue = 0
            }
            history.text = opStack
        }
    }

    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        let (result, opStack) = brain.pushOperand(displayValue)
        if (result != nil) {
            displayValue = result!
        } else {
            displayValue = 0
        }
        history.text = opStack
    }
    
    var displayValue : Double {
        get {
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}