//
//  TodoItem.swift
//  Todoey
//
//  Created by Andres Vazquez on 2018-05-28.
//  Copyright © 2018 Andres Vazquez. All rights reserved.
//

import UIKit

class TodoItem {
    
    var title: String
    var colorScheme: ColorScheme
    var colorValue: CGFloat {
        didSet {
            if colorValue < 0 {
                colorValue = 0
            }
            else if colorValue > 255 {
                colorValue = 255
            }
        }
    }
    var backgroundColor: UIColor {
        switch colorScheme {
        case .red:
            return UIColor(red: colorValue)
        case .green:
            return UIColor(green: colorValue)
        case .blue:
            return UIColor(blue: colorValue)
        }
    }
    
    init(title: String, colorScheme: ColorScheme, colorValue: CGFloat) {
        self.title = title
        self.colorScheme = colorScheme
        self.colorValue = colorValue
    }
}
