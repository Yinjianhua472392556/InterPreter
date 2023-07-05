//
//  AST+Extensions.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/3.
//

import UIKit

extension UnaryOperationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .minus:
            return "-"
        case .plus:
            return "+"
        }
    }
}

extension Number: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .integer(value):
            return "INTEGER(\(value))"
        case let .real(value):
            return "REAL(\(value))"
        }
    }
}

extension Number: Equatable {
    public static func == (lhs: Number, rhs: Number) -> Bool {
        switch (lhs, rhs) {
        case let (.integer(left), .integer(right)):
            return left == right
        case let (.real(left), .real(right)):
            return left == right
        case let (.real(left), .integer(right)):
            return left == Double(right)
        case let (.integer(left), .real(right)):
            return Double(left) == right
        }
    }
}

extension BinaryOperationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .minus:
            return "-"
        case .plus:
            return "+"
        case .mult:
            return "*"
        case .floatDiv:
            return "//"
        case .integerDiv:
            return "/"
        }
    }
}

extension ConditionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .equals:
            return "="
        case .greaterThan:
            return ">"
        case .lessThan:
            return "<"
        }
    }
}

extension AST {
    
    var value: String {
        switch self {
        case let number as Number:
            return "\(number)"
        case let unaryOperation as UnaryOperation:
            return "u\(unaryOperation.operation)"
        case let binaryOperation as BinaryOperation:
            return "\(binaryOperation.operation)"
        case is NoOp:
            return "noOp"
        case let variable as Variable:
            return variable.name
        case is Compound:
            return "compound"
        case is Assignment:
            return ":="
        case is Block:
            return "block"
        case is VariableDeclaration:
            return "var"
        case let type as VariableType:
            return "\(type.type)"
        case let program as Program:
            return program.name
        case let function as Function:
            return "\(function.name):\(function.returnType.type)"
        case let procedure as Procedure:
            return procedure.name
        case let param as Param:
            return "param\(param.name)"
        case let call as FunctionCall:
            return "\(call.name)()"
        case is IfElse:
            return "IF"
        case let condition as Condition:
            return condition.type.description
        case let string as String:
            return string
        case let boolean as Bool:
            return boolean ? "TRUE" : "FALSE"
        case is RepeatUntil:
            return "REPEAT"
        case is For:
            return "FOR"
        case is While:
            return "WHILE"
        default:
            fatalError("Missed AST case \(self)")
        }
    }
    
    
    var children: [AST] {
        switch self {
        case is Number:
            return []
        case let unaryOperation as UnaryOperation:
            return [unaryOperation.operand]
        case let binaryOperation as BinaryOperation:
            return [binaryOperation.left, binaryOperation.right]
        case is NoOp:
            return []
        case is Variable:
            return []
        case let compound as Compound:
            return compound.children
        case let assignment as Assignment:
            return [assignment.left, assignment.right]
        case let block as Block:
            var nodes: [AST] = []
            for declaration in block.declarations {
                nodes.append(declaration)
            }
            nodes.append(block.compound)
            return nodes
        case let variableDeclaration as VariableDeclaration:
            return [variableDeclaration.variable, variableDeclaration.type]
        case is VariableType:
            return []
        case let program as Program:
            return [program.block]
        case let function as Function:
            var nodes: [AST] = []
            for param in function.params {
                nodes.append(param)
            }
            nodes.append(function.block)
            return nodes
        case let procedure as Procedure:
            var nodes: [AST] = []
            for param in procedure.params {
                nodes.append(param)
            }
            nodes.append(procedure.block)
            return nodes
        case let param as Param:
            return [param.type]
        case let call as FunctionCall:
            return call.actualParameters
        case let ifelse as IfElse:
            if let falseExpression = ifelse.falseExpression {
                return [ifelse.condition, ifelse.trueExpression, falseExpression]
            }
            return [ifelse.condition, ifelse.trueExpression]
        case let condition as Condition:
            return [condition.leftSide, condition.rightSide]
        case is String:
            return []
        case is Bool:
            return []
        case let repeatUntil as RepeatUntil:
            return [repeatUntil.condition, repeatUntil.statement]
        case let whileLoop as While:
            return [whileLoop.condition, whileLoop.statement]
        case let forLoop as For:
            return [forLoop.variable, forLoop.startValue, forLoop.endValue, forLoop.statement]
        default:
            fatalError("Missed AST case \(self)")
        }
    }

    /**
     生成当前节点及其子节点的文本表示，并返回一个字符串数组。

     - Parameters:
       - nodeIndent: 节点的缩进字符串，默认为空字符串。
       - childIndent: 子节点的缩进字符串，默认为空字符串。

     - Returns: 当前节点及其子节点的文本表示数组。
     */
    func treeLines(_ nodeIndent: String = "", _ childIndent: String = "") -> [String] {
        // 生成当前节点的文本表示，并添加到结果列表中
        let nodeLine = nodeIndent + value
        var lines = [nodeLine]
        
        // 遍历当前节点的子节点，并将它们的文本表示添加到结果列表中
        for (index, child) in children.enumerated() {
            // 判断当前子节点是否是最后一个节点
            let isLastChild = index == children.count - 1
            // 根据当前子节点的位置，选择合适的缩进字符串
            let childIndentChar = isLastChild ? "┗╸" : "┣╸"
            let newChildIndent = childIndent + (isLastChild ? "  " : "| ")
            
            // 递归生成子节点的文本表示，并添加到结果列表中
            let childLines = child.treeLines(childIndentChar, newChildIndent)
            lines += childLines
        }
        // 返回结果列表
        return lines
    }
    
    /**
     打印当前节点及其子节点的文本表示。
     */
    func printTree() {
        // 生成节点的文本表示数组
        let lines = treeLines()
        
        // 输出文本表示到控制台
        print(lines.joined(separator: "\n"))
    }
}
