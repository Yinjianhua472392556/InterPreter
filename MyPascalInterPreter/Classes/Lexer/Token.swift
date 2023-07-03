//
//  Token.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/3.
//

import UIKit

public enum Operation {
    case plus
    case minus
    case mult
    case integerDiv
    case floatDiv
}

public enum Parenthesis {
    case left
    case right
}

public enum Bracket {
    case left
    case right
}

public enum Constant {
    case integer(Int)
    case real(Double)
    case boolean(Bool)
    case string(String)
}

public enum Type {
    case integer
    case real
    case boolean
    case string
}

public enum Token {
    case operation(Operation)
    case eof
    case parenthesis(Parenthesis)
    case begin
    case end
    case id(String)
    case dot
    case assign
    case semi
    case program
    case varDef
    case colon
    case coma
    case type(Type)
    case constant(Constant)
    case procedure
    case `if`
    case `else`
    case then
    case equals
    case lessThan
    case greaterThan
    case function
    case apostrophe
    case `repeat`
    case until
    case `for`
    case to
    case `do`
    case `while`
    case array
    case of
    case bracket(Bracket)
}
