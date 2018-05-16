//
//  BBSevenSegmentView.swift
//  SevenSegmentViewSampler
//
//  Created by MyCom on 5/11/18.
//  Copyright © 2018 MyCom. All rights reserved.
//


import UIKit

@IBDesignable
class BBSevenSegmentView: UIView {
    
    enum Pins {
        case A
        case B
        case C
        case D
        case E
        case F
        case G
        case DP
        case QM
        
        static let Values: [Pins] = [.A, .B, .C, .D, .E, .F, .G, .DP, .QM]
    }
    
    // protected
    var switchesOnPins: [Pins: Bool] = [.A: false, .B: false, .C: false, .D: false, .E: false, .F: false, .G: false, .DP: false, .QM: false]

    @IBInspectable
    var pinA: Bool {
        set {
            switchesOnPins[Pins.A] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.A]!
        }
    }
    
    @IBInspectable
    var pinB: Bool {
        set {
            switchesOnPins[Pins.B] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.B]!
        }
    }
    
    @IBInspectable
    var pinC: Bool {
        set {
            switchesOnPins[Pins.C] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.C]!
        }
    }
    
    @IBInspectable
    var pinD: Bool {
        set {
            switchesOnPins[Pins.D] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.D]!
        }
    }
    
    @IBInspectable
    var pinE: Bool {
        set {
            switchesOnPins[Pins.E] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.E]!
        }
    }
    
    @IBInspectable
    var pinF: Bool {
        set {
            switchesOnPins[Pins.F] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.F]!
        }
    }
    
    @IBInspectable
    var pinG: Bool {
        set {
            switchesOnPins[Pins.G] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.G]!
        }
    }
    
    @IBInspectable
    var pinDP: Bool {
        set {
            switchesOnPins[Pins.DP] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.DP]!
        }
    }
    
    @IBInspectable
    var pinQM: Bool {
        set {
            switchesOnPins[Pins.QM] = newValue
            setNeedsDisplay()
        }
        get {
            return switchesOnPins[Pins.QM]!
        }
    }
    
    @IBInspectable
    var pinBits: Int16 {
        set {
            switchesOnPins[Pins.A] = (newValue >> 0) & 1 == 1
            switchesOnPins[Pins.B] = (newValue >> 1) & 1 == 1
            switchesOnPins[Pins.C] = (newValue >> 2) & 1 == 1
            switchesOnPins[Pins.D] = (newValue >> 3) & 1 == 1
            switchesOnPins[Pins.E] = (newValue >> 4) & 1 == 1
            switchesOnPins[Pins.F] = (newValue >> 5) & 1 == 1
            switchesOnPins[Pins.G] = (newValue >> 6) & 1 == 1
            switchesOnPins[Pins.DP] = (newValue >> 7) & 1 == 1
            switchesOnPins[Pins.QM] = (newValue >> 8) & 1 == 1
            setNeedsDisplay()
        }
        get {
            var value: Int16 = 0
            value |= (switchesOnPins[Pins.A]! ? 1 : 0) << 0
            value |= (switchesOnPins[Pins.B]! ? 1 : 0) << 1
            value |= (switchesOnPins[Pins.C]! ? 1 : 0) << 2
            value |= (switchesOnPins[Pins.D]! ? 1 : 0) << 3
            value |= (switchesOnPins[Pins.E]! ? 1 : 0) << 4
            value |= (switchesOnPins[Pins.F]! ? 1 : 0) << 5
            value |= (switchesOnPins[Pins.G]! ? 1 : 0) << 6
            value |= (switchesOnPins[Pins.DP]! ? 1 : 0) << 7
            value |= (switchesOnPins[Pins.QM]! ? 1 : 0) << 8
            return value
        }
    }
    
    @IBInspectable
    var onColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var offColor: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        onColor = tintColor
        offColor = tintColor.withAlphaComponent(0.05)
        
        self.backgroundColor = UIColor.clear
    }
    
}
