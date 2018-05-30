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
    var isChecked: Bool = false
    var colorValue: CGFloat
    
    init(title: String, colorValue: CGFloat) {
        self.title = title
        self.colorValue = colorValue
    }
}
