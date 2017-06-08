//
//  CircleTime.swift
//  Circle-Time
//
//  Created by mitchell hudson on 6/8/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class CircleTime: UIView {
    
    var radius:CGFloat = 0
    
    var startTime = CFTimeInterval()
    var endTime = CFTimeInterval()
    
    let startTimeView = CircleButton()
    let endTimeView = CircleButton()
    
    let circleLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    
    func setup() {
        addSubview(startTimeView)
        addSubview(endTimeView)
        layer.addSublayer(circleLayer)
        let circleRect = bounds.insetBy(dx: 15, dy: 15)
        let circlePath = UIBezierPath(ovalIn: circleRect)
        circleLayer.path = circlePath.cgPath
        circleLayer.lineWidth = 1
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        
        radius = circleRect.width / 2
        let centerX = bounds.width / 2
        let centerY = bounds.height / 2
        
        let r1 = CGFloat(arc4random_uniform(1000)) / 1000 * CGFloat(M_PI) * 2
        let x1 = cos(r1) * radius + centerX
        let y1 = sin(r1) * radius + centerY
        
        startTimeView.center.x = x1
        startTimeView.center.y = y1
        
        let r2 = CGFloat(arc4random_uniform(1000)) / 1000 * CGFloat(M_PI) * 2
        let x2 = cos(r2) * radius + centerX
        let y2 = sin(r2) * radius + centerY
        
        endTimeView.center.x = x2
        endTimeView.center.y = y2
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Mark starting rotation...
        let touch = touches.first!
        let point = touch.location(in: self)
        positionCircle(touchPoint: point)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // update current rotation...
        let touch = touches.first!
        let point = touch.location(in: self)
        positionCircle(touchPoint: point)
    }
    
    func positionCircle(touchPoint: CGPoint) {
        let centerX = bounds.midX
        let centerY = bounds.midY
        let x = touchPoint.x - centerX
        let y = touchPoint.y - centerY
        let angle = atan2(y, x)
        let x1 = cos(angle) * radius + centerX
        let y1 = sin(angle) * radius + centerY
        startTimeView.center.x = x1
        startTimeView.center.y = y1
    }
    
    
}









