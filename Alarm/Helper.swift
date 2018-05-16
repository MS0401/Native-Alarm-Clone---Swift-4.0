//
//  Helper.swift
//  Alarm-ios-swift
//
//  Created by MyCom on 5/13/18.
//  Copyright © 2018 LongGames. All rights reserved.
//

import Foundation
import UIKit

//MARK: Get hour(i.e 9)
func GetCurrentHH() -> String {
    let hhformatter = DateFormatter()
    hhformatter.dateStyle = DateFormatter.Style.long
    hhformatter.timeStyle = .medium
    hhformatter.dateFormat = "h"
    let hhString = hhformatter.string(from: Date())
    return hhString
}

//MARK: Get minute(i.e: 18)
func GetCurrentMM() -> String {
    
    let mmformatter = DateFormatter()
    mmformatter.dateStyle = DateFormatter.Style.long
    mmformatter.timeStyle = .medium
    mmformatter.dateFormat = "mm"
    let mmString = mmformatter.string(from: Date())
    return mmString
}

//MARK: Get second (i.e: 18)
func GetCurrentSS() -> String {
    
    let ssformatter = DateFormatter()
    ssformatter.dateStyle = DateFormatter.Style.long
    ssformatter.timeStyle = .medium
    ssformatter.dateFormat = "ss"
    let ssString = ssformatter.string(from: Date())
    return ssString
}

//MARK: Get AM or PM string(i.e: "AM")
func GetCurrentAMPM() -> String {
    
    let ampmformatter = DateFormatter()
    ampmformatter.dateStyle = DateFormatter.Style.long
    ampmformatter.timeStyle = .medium
    ampmformatter.dateFormat = "a"
    let ampmString = ampmformatter.string(from: Date())
    return ampmString
}

//MARK: Get month string(i.e: "SEP")
func GetCurrentMMMM() -> String {
    
    let mmmmformatter = DateFormatter()
    mmmmformatter.dateStyle = DateFormatter.Style.long
    mmmmformatter.timeStyle = .medium
    mmmmformatter.dateFormat = "MMMM"
    let mmmmString = mmmmformatter.string(from: Date())
    return mmmmString
}

//MARK: Get date(i.e: 9)
func GetCurrentDD() -> String {
    
    let ddformatter = DateFormatter()
    ddformatter.dateStyle = DateFormatter.Style.long
    ddformatter.timeStyle = .medium
    ddformatter.dateFormat = "dd"
    let ddString = ddformatter.string(from: Date())
    return ddString
}

//MARK: Get day(i.e: "sunday")
func GetCurrentEEEE() -> String {
    
    let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
    return formatter.string(from: Date())
}

func GetScheduledEEEE(date: Date) -> Int {
    
    let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
    let day = formatter.string(from: date)
    
    var index = Int()
    switch day {
    case "Sunday":
        index = 1
    case "Monday":
        index = 2
    case "Tuesday":
        index = 3
    case "Wednesday":
        index = 4
    case "Thursday":
        index = 5
    case "Friday":
        index = 6
    case "Saturday":
        index = 7        
    default:
        break
    }
    
    return index
    
}

//MARK: Getting swipe direction in pan gesture recorgnizer.
public enum Direction: Int {
    case Up
    case Down
    case Left
    case Right
    
    public var isX: Bool { return self == .Left || self == .Right }
    public var isY: Bool { return !isX }
}

public extension UIPanGestureRecognizer {
    
    public var direction: Direction? {
        let velocity = self.velocity(in: view)
        let vertical = fabs(velocity.y) > fabs(velocity.x)
        switch (vertical, velocity.x, velocity.y) {
        case (true, _, let y) where y < 0: return .Up
        case (true, _, let y) where y > 0: return .Down
        case (false, let x, _) where x > 0: return .Right
        case (false, let x, _) where x < 0: return .Left
        default: return nil
        }
    }
}

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[Range(start ..< end)])
    }
    
    var numberValue: NSNumber? {
        if let value = Int(self) {
            return NSNumber(value: value)
        }
        return nil
    }
}

//MARK: extension UIColor(hexcolor)
extension UIColor {
    
    // Convert UIColor from Hex to RGB
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
}

