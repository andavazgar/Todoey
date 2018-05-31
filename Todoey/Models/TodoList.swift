//
//  TodoList.swift
//  Todoey
//
//  Created by Andres Vazquez on 2018-05-30.
//  Copyright © 2018 Andres Vazquez. All rights reserved.
//

import UIKit

class TodoList: Codable {
    var todoItems = [TodoItem]()
    var colorScheme: ColorScheme
    var isDarkening: Bool = true
    var gradientJump: CGFloat = 25
    private var minimumColorValue: CGFloat {
        return 2 * gradientJump
    }
    
    init() {
        colorScheme = .red
    }
    
    init(withColorScheme colorScheme: ColorScheme) {
        self.colorScheme = colorScheme
    }
    
    func getNextColorValue() -> CGFloat {
        var nextColorValue: CGFloat = 255
        let lastTodoItem = todoItems.last
        
        if let lastColorValueUsed = lastTodoItem?.colorValue {
            nextColorValue = isDarkening ? (lastColorValueUsed - gradientJump) : (lastColorValueUsed + gradientJump)
            
            if nextColorValue < minimumColorValue {
                isDarkening = false
                nextColorValue = lastColorValueUsed + gradientJump
            }
            else if nextColorValue > 255 {
                isDarkening = true
                nextColorValue = lastColorValueUsed - gradientJump
            }
        }
        
        return nextColorValue
    }
    
    func getBackgroundColor(forTodoItem todoItem: TodoItem) -> UIColor {
        switch colorScheme {
        case .red:
            return UIColor(red: todoItem.colorValue)
        case .green:
            return UIColor(green: todoItem.colorValue)
        case .blue:
            return UIColor(blue: todoItem.colorValue)
        }
    }
}
