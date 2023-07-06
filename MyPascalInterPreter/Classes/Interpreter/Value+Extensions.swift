//
//  Value+Extensions.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/6.
//

import UIKit

extension Value: Equatable {
    
    static func ==(lhs: Value, rhs: Value) -> Bool {
        switch (lhs, rhs) {
        case let (.number(left), .number(right)):
            return left == right
        case let (.boolean(left), .boolean(right)):
            return left == right
        case let (.string(left), .string(right)):
            return left == right
        default:
            return false
        }
    }
    
}


extension Value: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .none:
            return "NIL"
        case let .boolean(value):
            return "BOOLEAN(\(value))"
        case let .string(value):
            return "STRING(\(value))"
        case let .number(number):
            switch number {
            case let .integer(value):
                return "INTEGER(\(value))"
            case let .real(value):
                return "REAL(\(value))"
            }
        }
    }
    
}
