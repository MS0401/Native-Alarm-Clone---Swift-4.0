//
//  BBSevenSegmentImageView.swift
//  SevenSegmentViewSampler
//
//  Created by MyCom on 5/11/18.
//  Copyright © 2018 MyCom. All rights reserved.
//


import UIKit

@IBDesignable
class BBSevenSegmentImageView: BBSevenSegmentView {
    private static var contentSize: CGSize!
    private static var contents: [Pins: UIImage]!
    
    private static var staticInitOnce = {0}()//dispatch_once_t();
    
    private static var staticInitialize: Void = {
        // Do this once
        contentSize = CGSize(width: 24, height: 40)
        
        var temp_contents: [Pins: UIImage] = [:]
        if let image = UIImage(named: "seven_segment_pin_a")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.A] = image
        }
        if let image = UIImage(named: "seven_segment_pin_b")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.B] = image
        }
        if let image = UIImage(named: "seven_segment_pin_c")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.C] = image
        }
        if let image = UIImage(named: "seven_segment_pin_d")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.D] = image
        }
        if let image = UIImage(named: "seven_segment_pin_e")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.E] = image
        }
        if let image = UIImage(named: "seven_segment_pin_f")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.F] = image
        }
        if let image = UIImage(named: "seven_segment_pin_g")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.G] = image
        }
        if let image = UIImage(named: "seven_segment_pin_dp")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.DP] = image
        }
        if let image = UIImage(named: "seven_segment_pin_qm")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate) {
            temp_contents[Pins.QM] = image
        }
        contents = temp_contents
        
    }()
    
    private class func staticInit() {
        _ = staticInitialize
    }
    
    // MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        BBSevenSegmentImageView.staticInit()
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        BBSevenSegmentImageView.staticInit()
        super.init(frame: frame)
    }
    
    // MARK: -
    
//    override func intrinsicContentSize() -> CGSize {
//        return BBSevenSegmentImageView.contentSize!
//    }
    
    override func draw(_ rect: CGRect) {
        let switchesOnPins = self.switchesOnPins
        
        onColor?.setFill()
        for pin in Pins.Values {
            if switchesOnPins[pin]! {
                BBSevenSegmentImageView.contents[pin]?.draw(at: CGPoint.zero)
            }
        }
        
        offColor?.setFill()
        for pin in Pins.Values {
            if !switchesOnPins[pin]! {
                BBSevenSegmentImageView.contents[pin]?.draw(at: CGPoint.zero)
            }
        }
    }

}
