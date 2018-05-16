//
//  BBSevenSegmentDrawingView.swift
//  SevenSegmentViewSampler
//
//  Created by MyCom on 5/11/18.
//  Copyright © 2018 MyCom. All rights reserved.
//


import UIKit

@IBDesignable
class BBSevenSegmentDrawingView: BBSevenSegmentView {
    private static var contentSize: CGSize!
    private static var contents: [Pins: UIBezierPath]!
    
    private static var staticInitOnce = {0}()
    
    private static var staticInitialize: Void = {
        
        contentSize = CGSize(width: 24, height: 40)
        
        var temp_contents: [Pins: UIBezierPath] = [:]
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 7.8, y: 0)) //CGPointMake(7.8, 0))
            path.addLine(to: CGPoint(x: 6.33, y: 1.65))
            path.addLine(to: CGPoint(x: 7.51, y: 3.27))
            path.addLine(to: CGPoint(x: 19.2, y: 3.27))
            path.addLine(to: CGPoint(x: 20.67, y: 1.62))
            path.addLine(to: CGPoint(x: 19.49, y: 0))
            path.addLine(to: CGPoint(x: 7.8, y: 0))
            path.close()
            temp_contents[Pins.A] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 20.98, y: 2.05))
            path.addLine(to: CGPoint(x: 19.31, y: 3.93))
            path.addLine(to: CGPoint(x: 18.18, y: 17.91))
            path.addLine(to: CGPoint(x: 19.52, y: 19.75))
            path.addLine(to: CGPoint(x: 21.19, y: 17.88))
            path.addLine(to: CGPoint(x: 22.32, y: 3.89))
            path.addLine(to: CGPoint(x: 20.98, y: 2.05))
            path.close()
            temp_contents[Pins.B] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 19.48, y: 20.58))
            path.addLine(to: CGPoint(x: 17.81, y: 22.46))
            path.addLine(to: CGPoint(x: 16.68, y: 36.44))
            path.addLine(to: CGPoint(x: 18.02, y: 38.29))
            path.addLine(to: CGPoint(x: 19.69, y: 36.41))
            path.addLine(to: CGPoint(x: 20.82, y: 22.42))
            path.addLine(to: CGPoint(x: 19.48, y: 20.58))
            path.close()
            temp_contents[Pins.C] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 4.8, y: 37.06))
            path.addLine(to: CGPoint(x: 3.33, y: 38.72))
            path.addLine(to: CGPoint(x: 4.51, y: 40.33))
            path.addLine(to: CGPoint(x: 16.2, y: 40.33))
            path.addLine(to: CGPoint(x: 17.67, y: 38.68))
            path.addLine(to: CGPoint(x: 16.49, y: 37.06))
            path.addLine(to: CGPoint(x: 4.8, y: 37.06))
            path.close()
            temp_contents[Pins.D] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 4.48, y: 20.58))
            path.addLine(to: CGPoint(x: 2.81, y: 22.46))
            path.addLine(to: CGPoint(x: 1.68, y: 36.44))
            path.addLine(to: CGPoint(x: 3.02, y: 38.29))
            path.addLine(to: CGPoint(x: 4.69, y: 36.41))
            path.addLine(to: CGPoint(x: 5.82, y: 22.42))
            path.addLine(to: CGPoint(x: 4.48, y: 20.58))
            path.close()
            temp_contents[Pins.E] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 5.98, y: 2.05))
            path.addLine(to: CGPoint(x: 4.31, y: 3.93))
            path.addLine(to: CGPoint(x: 3.18, y: 17.91))
            path.addLine(to: CGPoint(x: 4.52, y: 19.75))
            path.addLine(to: CGPoint(x: 6.19, y: 17.88))
            path.addLine(to: CGPoint(x: 7.32, y: 3.89))
            path.addLine(to: CGPoint(x: 5.98, y: 2.05))
            path.close()
            temp_contents[Pins.F] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 6.3, y: 18.53))
            path.addLine(to: CGPoint(x: 4.83, y: 20.19))
            path.addLine(to: CGPoint(x: 6.01, y: 21.8))
            path.addLine(to: CGPoint(x: 17.7, y: 21.8))
            path.addLine(to: CGPoint(x: 19.17, y: 20.15))
            path.addLine(to: CGPoint(x: 17.99, y: 18.53))
            path.addLine(to: CGPoint(x: 6.3, y: 18.53))
            path.close()
            temp_contents[Pins.G] = path
        }
        do {
            let path = UIBezierPath(ovalIn: CGRect(x: 21, y: 37, width: 3, height: 3)) //UIBezierPath(ovalInRect: CGRect(x: 21, y: 37, width: 3, height: 3))
            temp_contents[Pins.DP] = path
        }
        do {
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 1.5, y: 0))
            path.addLine(to: CGPoint(x: 1.5, y:  0))
            path.addCurve(to: CGPoint(x: 0, y: 1.64), controlPoint1: CGPoint(x: 0.67, y: 0), controlPoint2: CGPoint(x: 0, y: 0.73))
            path.addLine(to: CGPoint(x: 0, y: 1.63))
            path.addCurve(to: CGPoint(x: 1.37, y: 3.26), controlPoint1: CGPoint(x: 0, y: 2.48), controlPoint2: CGPoint(x: 0.59, y: 3.19))
            path.addCurve(to: CGPoint(x: 1.32, y: 3.98), controlPoint1: CGPoint(x: 1.37, y: 3.5), controlPoint2: CGPoint(x: 1.35, y: 3.74))
            path.addCurve(to: CGPoint(x: 1.18, y: 4.67), controlPoint1: CGPoint(x: 1.29, y: 4.21), controlPoint2: CGPoint(x: 1.24, y: 4.44))
            path.addCurve(to: CGPoint(x: 0.95, y: 5.33), controlPoint1: CGPoint(x: 1.12, y: 4.89), controlPoint2: CGPoint(x: 1.04, y: 5.11))
            path.addCurve(to: CGPoint(x: 0.63, y: 5.95), controlPoint1: CGPoint(x: 0.85, y: 5.54), controlPoint2: CGPoint(x: 0.75, y: 5.75))
            path.addCurve(to: CGPoint(x: 1.61, y: 5.17), controlPoint1: CGPoint(x: 0.99, y: 5.74), controlPoint2: CGPoint(x: 1.32, y: 5.47))
            path.addCurve(to: CGPoint(x: 2.36, y: 4.15), controlPoint1: CGPoint(x: 1.9, y: 4.87), controlPoint2: CGPoint(x: 2.16, y: 4.52))
            path.addCurve(to: CGPoint(x: 2.83, y: 2.95), controlPoint1: CGPoint(x: 2.57, y: 3.78), controlPoint2: CGPoint(x: 2.73, y: 3.37))
            path.addCurve(to: CGPoint(x: 2.99, y: 1.83), controlPoint1: CGPoint(x: 2.93, y: 2.59), controlPoint2: CGPoint(x: 2.97, y: 0.21))
            path.addLine(to: CGPoint(x: 2.99, y: 1.82))
            path.addCurve(to: CGPoint(x: 3, y: 1.62), controlPoint1: CGPoint(x: 3, y: 1.75), controlPoint2: CGPoint(x: 3, y: 1.69))
            path.addLine(to: CGPoint(x: 3, y: 1.64))
            path.addCurve(to: CGPoint(x: 1.5, y: 0), controlPoint1: CGPoint(x: 3, y: 0.73), controlPoint2: CGPoint(x: 2.33, y: 0))
            path.close()
            temp_contents[Pins.QM] = path
        }
        contents = temp_contents
    }()
    
    private static func staticInit() {
        
        _ = staticInitialize        
    }

    // MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        BBSevenSegmentDrawingView.staticInit()
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        BBSevenSegmentDrawingView.staticInit()
        super.init(frame: frame)
    }
    
    // MARK: -
    
//    override func intrinsicContentSize() -> CGSize {
//        return BBSevenSegmentDrawingView.contentSize!
//    }
    
    override func draw(_ rect: CGRect) {
        let switchesOnPins = self.switchesOnPins
        
        let ctx = UIGraphicsGetCurrentContext()
        ctx!.concatenate(CGAffineTransform(scaleX: bounds.width / BBSevenSegmentDrawingView.contentSize.width, y: bounds.height / BBSevenSegmentDrawingView.contentSize.height))
        
        onColor?.setFill()
        for pin in Pins.Values {
            if switchesOnPins[pin]! {
                BBSevenSegmentDrawingView.contents[pin]?.fill()
            }
        }
        
        offColor?.setFill()
        for pin in Pins.Values {
            if !switchesOnPins[pin]! {
                BBSevenSegmentDrawingView.contents[pin]?.fill()
            }
        }
    }
    
}
