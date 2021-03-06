//
//  MusicViewController.swift
//  Alarm-ios-swift
//
//  Created by longyutao on 16/2/3.
//  Copyright (c) 2016年 LongGames. All rights reserved.
//

import UIKit
import MediaPlayer

protocol GotoMedia {
    func GotoMediaViewController(mediaID: String, mediaLabel: String, mediaTitle: String)
}

class MediaViewController: UIViewController, MPMediaPickerControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var delegate: GotoMedia! = nil
    
    fileprivate let numberOfRingtones = 10
    var mediaItem: MPMediaItem?
    var mediaLabel: String!
    var mediaID: String!
    var mediaid: NSNumber!
    var selectedMediaTitle: String = ""
    var selectedMediaID: String = ""
    
    var soundstitles = ["8bit", "2000hzbeep", "Classic Alarm", "Cuckcooclock", "Dance", "Dogwhistle", "Loudring", "Oldphone", "Pingpong", "Sawing"]
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var back: UIImageView!
    var mediaPicker: MPMediaPickerController?
    
    var localplayBOOL: Bool = false
    var applePlayBOOL: Bool = false
    var backgroundTask = BackgroundTask()
    var myMusicPlayer: MPMusicPlayerController?
    var selectIndex = 100

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.back.image = self.back.image!.withRenderingMode(.alwaysTemplate)
        self.back.tintColor = UIColor.init(netHex: 0xFFB01A)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        if localplayBOOL {
            backgroundTask.stopBackgroundTask()
            localplayBOOL = false
        }
        
        if applePlayBOOL {
            self.myMusicPlayer?.stop()
            applePlayBOOL = false
        }
        
        delegate.GotoMediaViewController(mediaID: self.mediaID, mediaLabel: self.mediaLabel, mediaTitle: self.selectedMediaTitle)
    }
    @IBAction func BackAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor =  UIColor.gray
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 10)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
        header.tintColor = UIColor.clear
    }
    

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
//        return 4
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if section == 0 {
            if self.selectedMediaTitle != "" {
                return 2
            }else {
                return 1
            }
        }
//        else if section == 1 {
//            return 1
//        }
//        else if section == 2 {
//            return 1
//        }
        else {
            return numberOfRingtones
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
//        if section == 0 {
//            return nil
//        }
//        else if section == 1 {
//            return nil
//        }
//        else if section == 2 {
//            return "SONGS"
//        }
//        else {
//            return "SOUNDS"
//        }
        if section == 0 {
            return "SONGS"
        }
        else {
            return "SOUNDS"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: Id.musicIdentifier)
        if(cell == nil) {
            cell = UITableViewCell(
                style: UITableViewCellStyle.default, reuseIdentifier: Id.musicIdentifier)
        }
//        if indexPath.section == 0 {
//            if indexPath.row == 0 {
//                cell!.textLabel!.text = "Buy More Tones"
//            }
//        }
//        else if indexPath.section == 1 {
//            cell!.textLabel!.text = "Vibration"
//            cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        }
        if indexPath.section == 0 {//2
            
            if indexPath.row == 0 {
                cell!.textLabel!.text = "Pick a song"
                cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            }else if indexPath.row == 1 {
                cell!.textLabel?.text = self.selectedMediaTitle
                if self.mediaID != "" {
                    cell!.accessoryType = UITableViewCellAccessoryType.checkmark
                }
                
            }
            
        }
        else if indexPath.section == 1 {//3
            
            cell!.textLabel!.text = self.soundstitles[indexPath.row]
            
            var lbl = cell?.textLabel?.text?.lowercased()
            if lbl == "classic alarm" {
                lbl = "Classic Alarm"
            }
            if lbl == mediaLabel {
                if self.mediaID == "" {
                    cell!.accessoryType = UITableViewCellAccessoryType.checkmark
                }
            }else {
                cell!.accessoryType = UITableViewCellAccessoryType.none
            }
        }
        
        cell!.textLabel?.textColor = UIColor.white
        cell!.backgroundColor = UIColor.init(netHex: 0x191919)
        //delete empty seperator line
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        mediaPicker = MPMediaPickerController(mediaTypes: MPMediaType.music)
        
        if let picker = mediaPicker {
            picker.delegate = self
            picker.prompt = "Select any song!"
            picker.allowsPickingMultipleItems = false
            
            let cell = tableView.cellForRow(at: indexPath)
            
            if indexPath.section == 0 {//2
                if indexPath.row == 0 {
                    
                    if localplayBOOL {
                        backgroundTask.stopBackgroundTask()
                        localplayBOOL = false
                    }
                    
                    if applePlayBOOL {
                        self.myMusicPlayer?.stop()
                        applePlayBOOL = false
                    }
                    
                    present(picker, animated: true, completion: nil)
                }else if indexPath.row == 1 {
                    mediaID = self.selectedMediaID
                    
                    cell?.accessoryType = UITableViewCellAccessoryType.checkmark
                    if localplayBOOL {
                        backgroundTask.stopBackgroundTask()
                        localplayBOOL = false
                    }
                    
                    if !applePlayBOOL {
                        self.playMediaPlayer(mediaID: self.mediaID)
                        applePlayBOOL = true
                    }else {
                        self.myMusicPlayer?.stop()
                        applePlayBOOL = false
                    }
                                        
                }
            }
            else if indexPath.section == 1 {//3
                
                cell?.accessoryType = UITableViewCellAccessoryType.checkmark
                if cell?.textLabel?.text == "Classic Alarm" {
                    mediaLabel = "Classic Alarm"
                }else {
                    mediaLabel = cell?.textLabel?.text!.lowercased()
                }
                
                mediaID = ""

                if applePlayBOOL {
                    self.myMusicPlayer?.stop()
                    applePlayBOOL = false
                }
                
                if !localplayBOOL {
                    
                    var soundname = ""
                    if soundstitles[indexPath.row] == "Classic Alarm" {
                        soundname = "classicalarm"
                    }else {
                        soundname = soundstitles[indexPath.row].lowercased()
                    }
                    
                    backgroundTask.startBackgroundTask(audioName: soundname)
                    localplayBOOL = true
                    self.selectIndex = indexPath.row
                }else {
                    backgroundTask.stopBackgroundTask()
                    localplayBOOL = false
                    if self.selectIndex != indexPath.row {
                        var soundname = ""
                        if soundstitles[indexPath.row] == "Classic Alarm" {
                            soundname = "classicalarm"
                        }else {
                            soundname = soundstitles[indexPath.row].lowercased()
                        }
                        
                        backgroundTask.startBackgroundTask(audioName: soundname)
                        localplayBOOL = true
                        self.selectIndex = indexPath.row
                    }
                }
                
            }
            
            cell?.setSelected(true, animated: true)
            cell?.setSelected(false, animated: true)
            let cells = tableView.visibleCells
            for c in cells {
                if (c != cell) {
                    c.accessoryType = UITableViewCellAccessoryType.none
                }
            }
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MPMediaPickerControllerDelegate
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems  mediaItemCollection:MPMediaItemCollection) -> Void {
        if !mediaItemCollection.items.isEmpty {
            let aMediaItem = mediaItemCollection.items[0]
        
            self.mediaItem = aMediaItem
            let id = self.mediaItem?.value(forProperty: MPMediaItemPropertyPersistentID) as! NSNumber
            self.selectedMediaTitle = self.mediaItem?.value( forProperty: MPMediaItemPropertyTitle ) as! String
            
            self.mediaID = String(describing: id)
            self.selectedMediaID = String(describing: id)
            
            self.tableView.reloadData()
            self.playMediaPlayer(mediaID: self.mediaID)
            self.applePlayBOOL = true
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func findSongWithPersistentIdString(persistentIDString: NSNumber) -> MPMediaItem? {
        let predicate = MPMediaPropertyPredicate(value: persistentIDString, forProperty: MPMediaItemPropertyPersistentID)
        let songQuery = MPMediaQuery()
        songQuery.addFilterPredicate(predicate)
        
        var song: MPMediaItem?
        if let items = songQuery.items, items.count > 0 {
            song = items[0]
        }
        return song
    }
    
    func playMediaPlayer(mediaID: String) {
        myMusicPlayer = MPMusicPlayerController()
        
        if mediaID != "" {
            if let media = mediaID.numberValue {
                let item = self.findSongWithPersistentIdString(persistentIDString: media)
                let mediaItemCollection = MPMediaItemCollection(items: [item!])
                
                myMusicPlayer?.setQueue(with: mediaItemCollection)
                myMusicPlayer?.play()
            }
            
        }
        
    }
}


