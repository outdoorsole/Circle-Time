//
//  CircleTime.swift
//  Circle-Time
//
//  Created by mitchell hudson on 6/8/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class CircleTime: UIView {
    
    // Holds the circlebutton that is currntly being dragged
    var circleButtonToDrag: CircleButton? = nil
    
    // Numbers needed to draw and position things
    var radius:CGFloat = 0
    var circleCenter: CGPoint!
    
    // Not in use...
    var startTime = CFTimeInterval()
    var endTime = CFTimeInterval()
    
    // Two buttons
    let startTimeView = CircleButton()
    let endTimeView = CircleButton()
    
    let circleLayer = CAShapeLayer()    // The thin background circle
    let lineLayer = CAShapeLayer()      // The thick transparent line between buttons
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Call setup after storyboard is done resizing views. 
        setup()
    }
    
    // TODO: Refactor into logical functions
    func setup() {
        
        // Draw Circle in back
        addSubview(startTimeView)
        addSubview(endTimeView)
        layer.addSublayer(circleLayer)
        let circleRect = bounds.insetBy(dx: 15, dy: 15)
        let circlePath = UIBezierPath(ovalIn: circleRect)
        circleLayer.path = circlePath.cgPath
        circleLayer.lineWidth = 1
        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        
        // Radius and Center
        radius = circleRect.width / 2
        let centerX = bounds.width / 2
        let centerY = bounds.height / 2
        circleCenter = CGPoint(x: centerX, y: centerY)
        
        // Position buttons at random angle
        let r1 = CGFloat(arc4random_uniform(1000)) / 1000 * CGFloat(Double.pi) * 2
        let x1 = cos(r1) * radius + centerX
        let y1 = sin(r1) * radius + centerY
        
        startTimeView.center.x = x1
        startTimeView.center.y = y1
        
        let r2 = CGFloat(arc4random_uniform(1000)) / 1000 * CGFloat(Double.pi) * 2
        let x2 = cos(r2) * radius + centerX
        let y2 = sin(r2) * radius + centerY
        
        endTimeView.center.x = x2
        endTimeView.center.y = y2
        
        startTimeView.angle = r1
        endTimeView.angle = r2
        
        // Setup lineLayer 
        layer.addSublayer(lineLayer)
        lineLayer.lineWidth = 30
        lineLayer.strokeColor = UIColor(hue: 0, saturation: 1, brightness: 1, alpha: 0.5).cgColor
        lineLayer.lineCap = "round"
        lineLayer.fillColor = UIColor.clear.cgColor
        drawLine()
    }
    
    // Draw the line between buttons
    func drawLine() {
        let startAngle = startTimeView.angle    // Get the starting angle and
        let endAngle = endTimeView.angle        // ending angle
        
        // Make a path and draw an arc between the angles
        let path = UIBezierPath(arcCenter: circleCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        // Set the path
        lineLayer.path = path.cgPath
    }
    
    // Handle touch events
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: Mark starting rotation...
        let touch = touches.first!              // Get the first touch
        let point = touch.location(in: self)    // find the location in this view
        
        // Perform a hittest and find the view at point
        let view = hitTest(point, with: nil)
        // Check if the view is a CircleButton
        if view is CircleButton {
            // If it's a CircleButton set it in this var for dragging
            circleButtonToDrag = (view as! CircleButton)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // TODO: update current rotation...
        let touch = touches.first!              // Get the first touch
        let point = touch.location(in: self)    // Find the point
        // If there is CircleButton to drag...
        if let circleButtonToDrag = circleButtonToDrag {
            // Call this method to position the button around the arc of the circle
            position(circleButton: circleButtonToDrag, touchPoint: point)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Drag is ended no more buttons to drag set this nil
        circleButtonToDrag = nil
    }
    
    func position(circleButton: CircleButton, touchPoint: CGPoint) {
        // Get the position of the touch relative to the center of the view.
        let x = touchPoint.x - circleCenter.x
        let y = touchPoint.y - circleCenter.y
        
        // Find the angle
        let angle = atan2(y, x)
        
        // let the button keep track of it's angle
        circleButton.angle = angle
        
        // Find the x and y coord for button and position the button
        let x1 = cos(angle) * radius + circleCenter.x
        let y1 = sin(angle) * radius + circleCenter.y
        circleButton.center.x = x1
        circleButton.center.y = y1
        
        // Draw the line between the two buttons
        drawLine()
    }
    
}









