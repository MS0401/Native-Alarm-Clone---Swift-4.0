//
//  ViewController.swift
//  AlarmClock
//
//  Created by MyCom on 5/9/18.
//  Copyright © 2018 MyCom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    let valueMap: [Int: Int16] = [
        0:0x3f,
        1:0x06,
        2:0x5b,
        3:0x4f,
        4:0x66,
        5:0x6d,
        6:0x7d,
        7:0x07,
        8:0x7f,
        9:0x6f,
        ]
    
    @IBOutlet var backgroundImg: UIImageView!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var hourTenNumber: BBSevenSegmentDrawingView!
    @IBOutlet var houroneNumber: BBSevenSegmentDrawingView!
    @IBOutlet var minuteTenNumber: BBSevenSegmentDrawingView!
    @IBOutlet var minuteoneNumber: BBSevenSegmentDrawingView!
    @IBOutlet var secondTenNumber: BBSevenSegmentDrawingView!
    @IBOutlet var secondoneNumber: BBSevenSegmentDrawingView!
    @IBOutlet var panGestureView: UIView!
    
    @IBOutlet var pmAndam: UIStackView!
    @IBOutlet var date: UIStackView!
    @IBOutlet var month: UIStackView!
    @IBOutlet var day: UIStackView!
    @IBOutlet var alarmImage: UIImageView!
    @IBOutlet var pmLabel: UILabel!
    @IBOutlet var monthLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var dot1: UIView!
    @IBOutlet var dot2: UIView!
    @IBOutlet var dot3: UIView!
    @IBOutlet var dot4: UIView!
    @IBOutlet var secondDotView: UIView!
    @IBOutlet var firstDotView: UIView!
    
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    var currenttimeTimer: Timer?
    var panTap: Int = 4
    var panTap1: Int = 3
    var loopIndex: Int = 0
    var colorArray: [UIColor] = [UIColor.init(netHex: 0x007AFF), UIColor.init(netHex: 0xFF8719), UIColor.init(netHex: 0x061320), UIColor.init(netHex: 0x5ED647), UIColor.init(netHex: 0xB468D6), UIColor.init(netHex: 0xBBD64F), UIColor.init(netHex: 0xffffff), UIColor.init(netHex: 0xffb6c1), UIColor.init(netHex: 0x3CB0FF)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.dayLabel.textColor = UIColor.init(netHex: 0x5ED647)
        self.monthLabel.textColor = UIColor.init(netHex: 0x5ED647)
        self.pmLabel.textColor = UIColor.init(netHex: 0x5ED647)
        self.dot1.backgroundColor = UIColor.init(netHex: 0x5ED647)
        self.dot1.layer.cornerRadius = self.dot1.frame.height/2
        self.dot2.backgroundColor = UIColor.init(netHex: 0x5ED647)
        self.dot2.layer.cornerRadius = self.dot2.frame.height/2
        self.dot3.backgroundColor = UIColor.init(netHex: 0x5ED647)
        self.dot3.layer.cornerRadius = self.dot3.frame.height/2
        self.dot4.backgroundColor = UIColor.init(netHex: 0x5ED647)
        self.dot4.layer.cornerRadius = self.dot4.frame.height/2
        self.hourTenNumber.onColor = UIColor.init(netHex: 0x5ED647)
        self.houroneNumber.onColor = UIColor.init(netHex: 0x5ED647)
        self.minuteTenNumber.onColor = UIColor.init(netHex: 0x5ED647)
        self.minuteoneNumber.onColor = UIColor.init(netHex: 0x5ED647)
        self.secondTenNumber.onColor = UIColor.init(netHex: 0x5ED647)
        self.secondoneNumber.onColor = UIColor.init(netHex: 0x5ED647)
        self.alarmImage.image = self.alarmImage.image!.withRenderingMode(.alwaysTemplate)
        self.alarmImage.tintColor = UIColor.init(netHex: 0x5ED647)
        
        if let temp_view = self.date.subviews[0] as? BBSevenSegmentView {
            temp_view.onColor = UIColor.init(netHex: 0x5ED647)
        }
        if let temp_view = self.date.subviews[1] as? BBSevenSegmentView {
            temp_view.onColor = UIColor.init(netHex: 0x5ED647)
        }
        
        self.firstDotView.isHidden = true
        self.secondDotView.isHidden = true
        
        self.backgroundImg.image = UIImage(named: "background4")

        
        self.createPanGestureRecognizerUIView(targetView: panGestureView)
        self.createPanGestureRecognizerImageView(targetView: self.view)
        
        //MARK: Running Timer in background state continuously.
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            UIApplication.shared.endBackgroundTask(self.backgroundTaskIdentifier!)
        })
        self.DisplayCurrentDatTime()
        self.currenttimeTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.DisplayCurrentDatTime), userInfo: nil, repeats: true)
        
    }
    
    //MARK: calling when device is rotating as portrait or landscape.
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.heightConstraint.constant = UIScreen.main.bounds.width / 3
        }else {
            self.heightConstraint.constant = 10//UIScreen.main.bounds.height * 0.191904053092003
        }
    }
    
    @IBAction func GotoAlarmList(_ sender: UIButton) {
    }
    
    
    @objc func DisplayCurrentDatTime() {
        
        if GetCurrentHH().characters.count != 2 {
            self.hourTenNumber.pinBits = valueMap[0]!
            self.hourTenNumber.alpha = 0.05
            self.houroneNumber.pinBits = valueMap[Int((GetCurrentHH()[0] as String))!]!
        }else {
            self.hourTenNumber.alpha = 1.0
            self.hourTenNumber.pinBits = valueMap[Int((GetCurrentHH()[0] as String))!]!
            self.houroneNumber.pinBits = valueMap[Int((GetCurrentHH()[1] as String))!]!
        }
        
        
        self.minuteTenNumber.pinBits = valueMap[Int((GetCurrentMM()[0] as String))!]!
        self.minuteoneNumber.pinBits = valueMap[Int((GetCurrentMM()[1] as String))!]!
        self.secondTenNumber.pinBits = valueMap[Int((GetCurrentSS()[0] as String))!]!
        self.secondoneNumber.pinBits = valueMap[Int((GetCurrentSS()[1] as String))!]!
        if GetCurrentDD().characters.count != 2 {
            if let date1 = self.date.subviews[1] as? BBSevenSegmentView {
                date1.pinBits = valueMap[Int((GetCurrentDD()[0]))!]!
            }
        }else {
            if let date0 = self.date.subviews[0] as? BBSevenSegmentView {
                date0.pinBits = valueMap[Int((GetCurrentDD()[0]))!]!
            }
            if let date1 = self.date.subviews[1] as? BBSevenSegmentView {
                date1.pinBits = valueMap[Int((GetCurrentDD()[1]))!]!
            }
        }
        
        self.dayLabel.text = GetCurrentEEEE()
        self.monthLabel.text = GetCurrentMMMM()
        self.pmLabel.text = GetCurrentAMPM()
        
        if loopIndex == 0 {
            loopIndex = 1
            self.secondDotView.isHidden = true
        }else {
            loopIndex = 0
            self.secondDotView.isHidden = false
        }
        self.firstDotView.isHidden = false
        
    }
    
    // The Pan Gesture
    func createPanGestureRecognizerUIView(targetView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action:#selector(self.handlePanGestureView(panGesture:)))
        targetView.addGestureRecognizer(panGesture)
    }
    
    func createPanGestureRecognizerImageView(targetView: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGestureImageView(panGesture:)))
        targetView.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePanGestureImageView(panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state == .began {
            
            if panGesture.direction == .Left {
                
                UIView.transition(with: self.backgroundImg,
                                  duration: 0.75,
                                  options: .transitionCrossDissolve,
                                  animations: { self.backgroundImg.image = UIImage(named: "background\(self.panTap)")
                                    

                },
                                  completion: nil)
                
                if self.panTap == 11 {
                    self.panTap = 1
                }else {
                    self.panTap = self.panTap + 1
                }
            }else if panGesture.direction == .Right {
                
                UIView.transition(with: self.backgroundImg,
                                  duration: 0.75,
                                  options: .transitionCrossDissolve,
                                  animations: { self.backgroundImg.image = UIImage(named: "background\(self.panTap)") },
                                  completion: nil)
                
                if self.panTap == 1 {
                    self.panTap = 11
                }else {
                    self.panTap = self.panTap - 1
                }
            }
        }
    }
    
    @objc func handlePanGestureView(panGesture: UIPanGestureRecognizer) {
        
        if panGesture.state == UIGestureRecognizerState.began {
            
            if panGesture.direction == .Left {
                
                UIView.transition(with: self.panGestureView, duration: 1, options: .transitionFlipFromRight, animations: {
                    
                    if self.panTap1 == 8 {
                        self.panTap1 = 0
                    }else {
                        self.panTap1 = self.panTap1 + 1
                    }
                }, completion: nil)
            }else if panGesture.direction == .Right {
                
                UIView.transition(with: self.panGestureView, duration: 1, options: .transitionFlipFromLeft, animations: {
                    
                    if self.panTap1 == 0 {
                        self.panTap1 = 8
                    }else {
                        self.panTap1 = self.panTap1 - 1
                    }
                }, completion: nil)
            }
            
            self.dayLabel.textColor = self.colorArray[self.panTap1]
            self.monthLabel.textColor = self.colorArray[self.panTap1]
            self.pmLabel.textColor = self.colorArray[self.panTap1]
            self.dot1.backgroundColor = self.colorArray[self.panTap1]
            self.dot2.backgroundColor = self.colorArray[self.panTap1]
            self.dot3.backgroundColor = self.colorArray[self.panTap1]
            self.dot4.backgroundColor = self.colorArray[self.panTap1]
            self.hourTenNumber.onColor = self.colorArray[self.panTap1]
            self.houroneNumber.onColor = self.colorArray[self.panTap1]
            self.minuteTenNumber.onColor = self.colorArray[self.panTap1]
            self.minuteoneNumber.onColor = self.colorArray[self.panTap1]
            self.secondTenNumber.onColor = self.colorArray[self.panTap1]
            self.secondoneNumber.onColor = self.colorArray[self.panTap1]
            
            if let temp_view = self.date.subviews[0] as? BBSevenSegmentView {
                temp_view.onColor = self.colorArray[self.panTap1]
            }
            if let temp_view = self.date.subviews[1] as? BBSevenSegmentView {
                temp_view.onColor = self.colorArray[self.panTap1]
            }
            
            self.alarmImage.image = self.alarmImage.image!.withRenderingMode(.alwaysTemplate)
            self.alarmImage.tintColor = self.colorArray[self.panTap1]

        }
        
        if panGesture.state == UIGestureRecognizerState.ended {
            
            
        }
        
        if panGesture.state == UIGestureRecognizerState.changed {
            
            
        } else {
            // or something when its not moving
        }
    }

}

