//
//  main.swift
//  SimpleCalc
//
//  Created by William on 4/1/17.
//  Copyright © 2017 Yang Wang. All rights reserved.
//

import Foundation

/**  Functions  ********************************************************************/

func isStringAnInt(string: String) -> Bool {
	return Int(string) != nil
}

func isStringAnFloat(string: String) -> Bool {
	return Float(string) != nil
}

func isLegalOperation(string: String) -> Bool {
	return string == "+" || string == "-" || string == "*" || string == "/" || string == "%"
}

func exitWithIllegalArgument() {
	print("Illegal argument: not a legal number\nProgram Terminated")
	exit(1)
}

func exitWithIllegalOperation() {
	print("Illegal operation: Unknown operation\nProgram Terminated")
	exit(1)
}

func OneLineExpression(expression : String) -> String {
	let expressionArr = expression.characters.split(separator: " ")
	if expressionArr.endIndex - 2 < 0 {
		print("Illegal Argument: Too less argument\nProgram Terminated")
		exit(1)
	}
	let operands = Array(expressionArr[0...(expressionArr.endIndex - 2)]).map{String($0)}
	switch String(expressionArr.last!) {
	case "avg":
		return String(average(operands: operands))
	case "count":
		return String(count(operands: operands))
	case "fact":
		return String(fact(operands: operands))
	default:
		return "Unknown operation"
	}
}

func average(operands : Array<String>) -> Float {
	var sum : Float = 0.0
	for operand in operands {
		guard isStringAnFloat(string: operand) else {exitWithIllegalArgument();return 0}
		sum += Float(operand)!
	}
	return sum/Float(operands.count)
}

func count(operands : Array<String>) -> Int {
	for operand in operands {
		guard isStringAnFloat(string: operand) else {exitWithIllegalArgument();return 0}
	}
	return operands.count
}

func fact(operands : Array<String>) -> UInt64 {
	if operands.count > 1
		|| Int(operands.first!) == nil
		|| Int(operands.first!)! < 1
		|| Int(operands.first!)! > 20
	{
		print("Input not legal: input should be single positive integer less than 20, please retry with another number \nProgram Terminated")
		exit(1)
	}
	let input = Int(operands.first!)!
	return fact(operand: input)
}

func fact(operand : Int) -> UInt64 {
	var sum : UInt64 = 1
	for index in 1...operand {
		sum *= UInt64(index)
	}
	return sum
}

func MultiLineExpression(number: String) -> String {
	guard isStringAnFloat(string: number) else {exitWithIllegalArgument();return ""}
	let operand_1 = Float(number)!
	let operation = readLine()!
	guard isLegalOperation(string: operation) else {exitWithIllegalOperation();return ""}
	let temp = readLine()!
	guard isStringAnFloat(string: temp) else {exitWithIllegalArgument();return ""}
	let operand_2 = Float(temp)!
	
	if operation == "%" && (!isStringAnInt(string: number) || !isStringAnInt(string: temp)) {
		print("Modular operation cannot be performed on non-integer\nProgram Terminated")
		exit(1)
	}
	
	switch operation {
	case "+":
		return ("\(operand_1 + operand_2)")
	case "-":
		return ("\(operand_1 - operand_2)")
	case "*":
		return ("\(operand_1 * operand_2)")
	case "/":
		return ("\(operand_1 / operand_2)")
	case "%":
		return ("\(Int(operand_1) % Int(operand_2))")
	default:
		return ("Unknown issue")
	}
}


/**  Main  *************************************************************************/


let welcome = "Welcome to use SimpleCalc. This is a command line calculator that helps you do some simple calculation.\n"

let usage = "Usage: calc <numbers... operation>\nOr simply\n\tcalc\n\nExpression should be of the form \"1+2\" or \"7*5\"\nNumber list and operation shouble be of the form \"1 2 3 avg\" or \"9 8 7 count\"\n\nSupport operations: \n\t avg for average \n\t count for counting elements \n\t fact for factorial (fact only accept one positive integer less than 20)"

if CommandLine.arguments.count > 1 {
	var exp = CommandLine.arguments[1...(CommandLine.arguments.count - 1)].joined(separator: " ")
	print("Result: " + OneLineExpression(expression : exp))
	exit(0)
}


print(welcome + "\n" + usage + "\n\nPlease enter your expression below:")

let str = readLine()!
if str.contains(" ") {
	print("Result: " + OneLineExpression(expression : str))
} else {
	print("Result: " + MultiLineExpression(number : str))
}

//for argument in CommandLine.arguments {
//	print(argument)
//}
