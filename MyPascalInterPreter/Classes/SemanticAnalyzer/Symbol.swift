//
//  Symbol.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/5.
//

import UIKit

protocol Symbol {
    var name: String { get }
}

enum BuiltInTypeSymbol: Symbol {
    case integer
    case real
    case boolean
    case string

    var name: String {
        switch self {
        case .integer:
            return "INTEGER"
        case .real:
            return "REAL"
        case .boolean:
            return "BOOLEAN"
        case .string:
            return "STRING"
        }
    }
}


class VariableSymbol: Symbol {
    let name: String
    let type: Symbol

    init(name: String, type: Symbol) {
        self.name = name
        self.type = type
    }
}

class ArraySymbol: VariableSymbol {
    let startIndex: Int
    let endIndex: Int

    init(name: String, type: Symbol, startIndex: Int, endIndex: Int) {
        self.startIndex = startIndex
        self.endIndex = endIndex
        super.init(name: name, type: type)
    }
}

class ProcedureSymbol: Symbol {
    let name: String
    let params: [Symbol]
    let body: Procedure

    init(name: String, params: [Symbol], body: Procedure) {
        self.name = name
        self.params = params
        self.body = body
    }
}

class FunctionSymbol: ProcedureSymbol {
    let returnType: Symbol

    init(name: String, params: [Symbol], body: Procedure, returnType: Symbol) {
        self.returnType = returnType
        super.init(name: name, params: params, body: body)
    }
}

class BuiltInProcedureSymbol: Symbol {
    let name: String
    let params: [Symbol]
    let hasVariableParameters: Bool

    init(name: String, parameters: [Symbol], hasVariableParameters: Bool) {
        self.name = name
        params = parameters
        self.hasVariableParameters = hasVariableParameters
    }
}
