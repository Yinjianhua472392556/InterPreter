//
//  Visitor.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/5.
//

import UIKit

protocol Visitor: AnyObject {
    func visit(node: AST)
    func visit(number: Number)
    func visit(unaryOperation: UnaryOperation)
    func visit(binaryOperation: BinaryOperation)
    func visit(compound: Compound)
    func visit(assignment: Assignment)
    func visit(variable: Variable)
    func visit(noOp: NoOp)
    func visit(block: Block)
    func visit(variableDeclaration: VariableDeclaration)
    func visit(type: VariableType)
    func visit(program: Program)
    func visit(procedure: Procedure)
    func visit(function: Function)
    func visit(param: Param)
    func visit(call: FunctionCall)
    func visit(condition: Condition)
    func visit(ifElse: IfElse)
    func visit(loop: Loop)
    func visit(forLoop: For)
}


extension Visitor {
    
    func visit(node: AST) {
        switch node {
        case let number as Number:
            visit(number: number)
        case let unaryOperation as UnaryOperation:
            visit(unaryOperation: unaryOperation)
        case let binaryOperation as BinaryOperation:
            visit(binaryOperation: binaryOperation)
        case let compound as Compound:
            visit(compound: compound)
        case let assignment as Assignment:
            visit(assignment: assignment)
        case let variable as Variable:
            visit(variable: variable)
        case let noOp as NoOp:
            visit(noOp: noOp)
        case let block as Block:
            visit(block: block)
        case let variableDeclaration as VariableDeclaration:
            visit(variableDeclaration: variableDeclaration)
        case let type as VariableType:
            visit(type: type)
        case let program as Program:
            visit(program: program)
        case let function as Function:
            visit(function: function)
        case let procedure as Procedure:
            visit(procedure: procedure)
        case let param as Param:
            visit(param: param)
        case let call as FunctionCall:
            visit(call: call)
        case let condition as Condition:
            visit(condition: condition)
        case let ifElse as IfElse:
            visit(ifElse: ifElse)
        case let loop as Loop:
            visit(loop: loop)
        case let forLoop as For:
            visit(forLoop: forLoop)
        default:
            fatalError("Unsupported node type \(node)")
        }
    }
    
    func visit(number _: Number) {
    }
    
    func visit(unaryOperation: UnaryOperation) {
        visit(node: unaryOperation.operand)
    }
    
    func visit(binaryOperation: BinaryOperation) {
        visit(node: binaryOperation.left)
        visit(node: binaryOperation.right)
    }

    func visit(compound: Compound) {
        for node in compound.children {
            visit(node: node)
        }
    }
    
    func visit(assignment: Assignment) {
        visit(node: assignment.left)
        visit(node: assignment.right)
    }
    
    func visit(variable _: Variable) {
    }

    func visit(noOp _: NoOp) {
    }
    
    func visit(block: Block) {
        for declaration in block.declarations {
            visit(node: declaration)
        }
        visit(node: block.compound)
    }
    
    func visit(variableDeclaration: VariableDeclaration) {
        visit(node: variableDeclaration.type)
    }

    func visit(type _: VariableType) {
    }

    func visit(program: Program) {
        visit(node: program.block)
    }

    func visit(procedure: Procedure) {
        for param in procedure.params {
            visit(node: param)
        }
        visit(node: procedure.block)
    }

    func visit(function: Function) {
        for param in function.params {
            visit(node: param)
        }
        visit(node: function.block)
        visit(node: function.returnType)
    }

    func visit(param: Param) {
        visit(node: param.type)
    }

    func visit(call: FunctionCall) {
        for parameter in call.actualParameters {
            visit(node: parameter)
        }
    }

    func visit(condition: Condition) {
        visit(node: condition.leftSide)
        visit(node: condition.rightSide)
    }

    func visit(ifElse: IfElse) {
        visit(node: ifElse.condition)
        visit(node: ifElse.trueExpression)

        if let falseExpression = ifElse.falseExpression {
            visit(node: falseExpression)
        }
    }

    func visit(loop: Loop) {
        visit(node: loop.statement)
        visit(node: loop.condition)
    }

    func visit(forLoop: For) {
//        visit(node: forLoop.variable)
        visit(node: forLoop.startValue)
        visit(node: forLoop.endValue)
        visit(node: forLoop.statement)
    }
    
}

