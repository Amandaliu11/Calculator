//
//  CalclulatorBrain.swift
//  CalculatorNew
//
//  Created by 刘玲 on 16/12/18.
//  Copyright © 2016年 Amanda Liu. All rights reserved.
//

import Foundation

public class CalculatorBrain{
    private var calculatorResult = 0.0
    
    private var operations:Dictionary<String,Operation> = [
        "×": Operation.BinaryOperation({$0 * $1}),
        "÷": Operation.BinaryOperation({$0 / $1}),
        "+": Operation.BinaryOperation({$0 + $1}),
        "−": Operation.BinaryOperation({$0 - $1}),
        "√": Operation.UnaryOperation(sqrt),
        "π": Operation.Constant(Double.pi),
        "=": Operation.Equals
    ]
    
    private enum Operation{
        case Constant(Double)
        case UnaryOperation((Double)->Double)
        case BinaryOperation((Double,Double)->Double)
        case Equals
    }
    
    func actionDigit(digit:Double){
        calculatorResult = digit
    }
    
    func actionOperation(operation:String){
        if let operationResult = operations[operation]{
            switch operationResult {
            case .Constant(let value):
                calculatorResult = value
                break
            case .UnaryOperation(let foo):
                calculatorResult = foo(calculatorResult)
                break;
            case .BinaryOperation(let foo):
                excutePending()
                pending = PendingBinaryOperationInfo(binaryFunction: foo, firstOperand: calculatorResult)
                break;
            case .Equals:
                excutePending()
                break;
            }
        }
    }
    
    func excutePending(){
        if pending != nil {
            calculatorResult = pending!.binaryFunction(pending!.firstOperand,calculatorResult)
            pending = nil
        }
    }

    private var pending:PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction:(Double,Double)->Double
        var firstOperand:Double
    }
    
    var result:Double{
        get{
            return calculatorResult
        }
    }
}
