//
//  Stack.swift
//  MyPascalInterPreter
//
//  Created by 尹建华 on 2023/7/6.
//

import UIKit

struct Stack<Element> {
    var array: [Element] = []
    
    mutating func push(_ element: Element) {
        array.append(element)
    }
    
    @discardableResult  mutating func pop() -> Element? {
        return array.popLast()
    }
    
    func peek() -> Element? {
        return array.last
    }
}
