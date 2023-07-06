//
//  SymbolTable.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/5.
//

import UIKit

class ScopedSymbolTable {
    var symbols: [String: Symbol] = [:]
    
    let name: String
    let level: Int
    // 符号表的上一级符号表
    let enclosingScope: ScopedSymbolTable?
    
    init(name: String, level: Int, enclosingScope: ScopedSymbolTable?) {
        self.name = name
        self.level = level
        self.enclosingScope = enclosingScope
    }
    
    
    func insertBuiltInTypes() {
        insert(BuiltInTypeSymbol.integer)
        insert(BuiltInTypeSymbol.real)
        insert(BuiltInTypeSymbol.boolean)
        insert(BuiltInTypeSymbol.string)
    }
    
    func insertBuildInProcedures() {
        symbols["WRITELN"] = BuiltInProcedureSymbol(name: "WRITELN", parameters: [], hasVariableParameters: true)
        symbols["WRITE"] = BuiltInProcedureSymbol(name: "WRITE", parameters: [], hasVariableParameters: true)
        symbols["READ"] = BuiltInProcedureSymbol(name: "READ", parameters: [], hasVariableParameters: true)
        symbols["READLN"] = BuiltInProcedureSymbol(name: "READLN", parameters: [], hasVariableParameters: true)
        symbols["RANDOM"] = BuiltInProcedureSymbol(name: "RANDOM", parameters: [BuiltInTypeSymbol.integer], hasVariableParameters: false)
        symbols["LENGTH"] = BuiltInProcedureSymbol(name: "LENGTH", parameters: [], hasVariableParameters: true)
    }
    
    func insert(_ symbol: Symbol) {
        symbols[symbol.name.uppercased()] = symbol
    }
    
    func lookup(_ name: String, currentScopeOnly: Bool = false) -> Symbol? {
        if let symbol = symbols[name.uppercased()] {
            return symbol
        }
        
        if currentScopeOnly {
            return nil
        }
        
        return enclosingScope?.lookup(name)
    }
    
    
}

extension ScopedSymbolTable: CustomStringConvertible {
    public var description: String {
        var lines = ["SCOPE (SCOPED SYMBOL TABLE)", "==========================="]
        lines.append("Scope name    : \(name)")
        lines.append("Scope level   : \(level)")
        lines.append("Scope (Scoped symbol table) contents")
        lines.append("------------------------------------")
        lines.append(contentsOf: symbols.sorted(by: { $0.value.sortOrder < $1.value.sortOrder }).map({ key, value in
            "\(key.padding(toLength: 12, withPad: " ", startingAt: 0)): \(value)"
        }))
        return lines.reduce("", { $0 + "\n" + $1 })
    }
}
