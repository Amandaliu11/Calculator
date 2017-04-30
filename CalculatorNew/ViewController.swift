//
//  ViewController.swift
//  CalculatorNew
//
//  Created by 刘玲 on 16/10/23.
//  Copyright © 2016年 Amanda Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var display: UILabel!
    
    //用户正在输入数字中
    private var userActionInMiddleDigit = false
    
    private var brain = CalculatorBrain()
    
    /* Action：用户点击数字 */
    @IBAction private func actionDigit(_ sender: UIButton) {
        if userActionInMiddleDigit {
            display.text = display.text! + sender.currentTitle!
        }else{
            display.text = sender.currentTitle
        }
        userActionInMiddleDigit = true
    }
    
    @IBAction private func actionOpera(_ sender: UIButton) {
        if userActionInMiddleDigit {
            brain.actionDigit(digit: displayValue)
            userActionInMiddleDigit = false
        }
        
        if let operationValue = sender.currentTitle{
            brain.actionOperation(operation: operationValue)
        }
        
        displayValue = brain.result
    }
    
    private var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = "\(newValue)"
        }
    }
    
    
}

