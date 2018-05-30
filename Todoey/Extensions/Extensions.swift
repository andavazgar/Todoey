//
//  Extensions.swift
//  Todoey
//
//  Created by Andres Vazquez on 2018-05-29.
//  Copyright © 2018 Andres Vazquez. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: CGFloat) {
        self.init(red: red/255, green: 0, blue: 0, alpha: 1)
    }
    
    convenience init(green: CGFloat) {
        self.init(red: 0, green: green/255, blue: 0, alpha: 1)
    }
    
    convenience init(blue: CGFloat) {
        self.init(red: 0, green: 0, blue: blue/255, alpha: 1)
    }
}
