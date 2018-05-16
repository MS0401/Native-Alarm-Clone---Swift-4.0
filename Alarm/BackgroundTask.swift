//
//  BackgroundTask.swift
//
//  Created by MyCom on 5/11/18.
//  Copyright © 2018 MyCom. All rights reserved.
//


import AVFoundation

class BackgroundTask {
    
    var player = AVAudioPlayer()
    var timer = Timer()
    var resourceName: String?
    
    func startBackgroundTask(audioName: String) {
        self.resourceName = audioName
        NotificationCenter.default.addObserver(self, selector: #selector(interuptedAudio), name: NSNotification.Name.AVAudioSessionInterruption, object: AVAudioSession.sharedInstance())
        self.playAudio(resourceName: audioName)
    }
    
    func stopBackgroundTask() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
        player.stop()
    }
    
    @objc fileprivate func interuptedAudio(_ notification: Notification) {
        if notification.name == NSNotification.Name.AVAudioSessionInterruption && notification.userInfo != nil {
            var info = notification.userInfo!
            var intValue = 0
            (info[AVAudioSessionInterruptionTypeKey]! as AnyObject).getValue(&intValue)
            if intValue == 1 { playAudio(resourceName: self.resourceName!) }
        }
    }
    
    fileprivate func playAudio(resourceName: String) {
        do {
            let bundle = Bundle.main.path(forResource: resourceName, ofType: "mp3")
            let alertSound = URL(fileURLWithPath: bundle!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with:AVAudioSessionCategoryOptions.mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            try self.player = AVAudioPlayer(contentsOf: alertSound)
            self.player.numberOfLoops = -1
            self.player.volume = 0.01
            self.player.prepareToPlay()
            self.player.play()
        } catch { print(error) }
    }
}
