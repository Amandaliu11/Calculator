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
            if (sender.currentTitle! == "." && hasDot(str: display.text!)){
                return;
            }
            
            display.text = display.text! + sender.currentTitle!
        }else{
            display.text = sender.currentTitle
        }
        userActionInMiddleDigit = true
    }
    
    /* Action: 用户点击“.” */
    @IBAction private func actionDot(_ sender: UIButton) {
        if (userActionInMiddleDigit
            && sender.currentTitle! == "."
            && hasDot(str: display.text!)){
            return;
        }
        
        actionDigit(sender)
    }
    
    /* Action: 用户点击了操作符 */
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
    
    /* 是否包括了“.” */
    private func hasDot(str:String) -> Bool{
        let varRange = str.range(of: ".");
        if (varRange != nil) {
            return true;
        }
        return false;
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

