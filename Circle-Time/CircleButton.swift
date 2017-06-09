//
//  CircleButton.swift
//  Circle-Time
//
//  Created by mitchell hudson on 6/8/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class CircleButton: UIView {
    
    var angle: CGFloat = 0
    
    init() {
        let rect = CGRect(x: 0, y: 0, width: 30, height: 30)
        super.init(frame: rect)
        
        backgroundColor = UIColor.black
        layer.cornerRadius = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
