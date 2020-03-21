//
//  QuickRatingViewController.swift
//  iTunesQuickRatingBar
//
//  Created by Rodrigo Villamil Pérez on 09/12/2018.
//  Copyright © 2018 Rodrigo Villamil Pérez. All rights reserved.
//

import Cocoa
import os

class QuickRatingViewController: NSViewController {
    
    @IBOutlet weak var currentTitle: NSTextField!
    @IBOutlet weak var currentAlbum: NSTextField!
    @IBOutlet weak var currentArtist: NSTextField!
    @IBOutlet weak var currentCover: NSImageView!
    @IBOutlet weak var currentHeart: NSButton!
    
    @IBOutlet weak var oneStar: NSButton!
    @IBOutlet weak var twoStar: NSButton!
    @IBOutlet weak var threeStar: NSButton!
    @IBOutlet weak var fourStar: NSButton!
    @IBOutlet weak var fiveStar: NSButton!
    @IBOutlet weak var quitButton: NSButton!
    @IBOutlet weak var playPauseButton: NSButton!
    
    let itunesWrapper = iTunesWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.observePlayerInfoNotification()
        self.updatePlayPauseButton(playerState: itunesWrapper.playerState())
    }
}

extension QuickRatingViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> QuickRatingViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name ("Main"),
                                      bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("QuickRatingViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? QuickRatingViewController else {
            fatalError("Why cant i find QuickRatingViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        self.updateView()
    }
    
    // MARK: - My functions
    func updateView(){
        if itunesWrapper.isApplicationRunning() {
            itunesWrapper.logCurrentSongInfo()
            self.updateViewTitle(value: itunesWrapper.currentTitle())
            self.updateViewAlbum(value: itunesWrapper.currentAlbum())
            self.updateViewArtist(value:itunesWrapper.currentArtist())
            self.updateViewCover(value: itunesWrapper.currentFirstCover())
            self.updateViewStars(value: itunesWrapper.currentNumberOfStars())
            self.updateViewHeart(isLoved: itunesWrapper.isCurrentSongLoved())
        }
    }
    
    func updateViewTitle (value:String){
        self.currentTitle.cell?.stringValue = value
        self.currentTitle.toolTip = value
    }
    
    func updateViewAlbum (value:String){
        self.currentAlbum.cell?.stringValue = value
        self.currentAlbum.toolTip = value
    }
    
    func updateViewArtist (value:String){
        self.currentArtist.cell?.stringValue = value
        self.currentArtist.toolTip = value
    }
    
    func updateViewCover (value:NSImage?){
        if let image = value {
            self.currentCover.image = image
        } else {
            self.currentCover.image = NSImage(named:NSImage.Name("defaultCover"))
        }
    }
  
    func updateViewHeart (isLoved:Bool){
        if (isLoved){
            currentHeart.image = NSImage(named:NSImage.Name("highlightedHeart"))
        } else {
            currentHeart.image = NSImage(named:NSImage.Name("emptyHeart"))
        }
    }
    
    
    // Stars
    func updateViewStars (value: Int){
        self.zeroStars()
        switch value {
        case 0:
            zeroStars()
        case 1:
            // highlightedStar
            oneStar.image = NSImage(named:NSImage.Name("highlightedStar"))
        case 2:
            oneStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            twoStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            
        case 3:
            oneStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            twoStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            threeStar.image = NSImage(named:NSImage.Name("highlightedStar"))
        case 4:
            oneStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            twoStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            threeStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            fourStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            
        case 5:
            oneStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            twoStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            threeStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            fourStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            fiveStar.image = NSImage(named:NSImage.Name("highlightedStar"))
            
        default:
            os_log("updateViewStars - Imposible")
        }
    }
    
    func zeroStars() {
        // highlightedStar
        oneStar.image = NSImage(named:NSImage.Name("emptyStar"))
        twoStar.image = NSImage(named:NSImage.Name("emptyStar"))
        threeStar.image = NSImage(named:NSImage.Name("emptyStar"))
        fourStar.image = NSImage(named:NSImage.Name("emptyStar"))
        fiveStar.image = NSImage(named:NSImage.Name("emptyStar"))
    }
    
    func updatePlayPauseButton (playerState: iTunesEPlS){
        switch playerState {
        case .paused:
            self.updatePlayPauseButton (playerState: "Paused")
        case .stopped:
            self.updatePlayPauseButton (playerState: "Stopped")
        case .playing:
            self.updatePlayPauseButton (playerState: "Playing")
        default:
            break
        }
    }
    
    func updatePlayPauseButton (playerState: String){
        
        switch playerState {
        case "Paused":
            os_log ("iTunes player, paused...")
            playPauseButton.image
                = NSImage(named:NSImage.Name("play-button"))
        case "Stopped":
            os_log ("iTunes player, stopped...")
            playPauseButton.image
                = NSImage(named:NSImage.Name("play-button"))
        case "Playing":
            playPauseButton.image
                = NSImage(named:NSImage.Name("pause-button"))
        default:
            break
        }
        self.updateView()
    }
    
    
    // MARK: Actions
    @IBAction func clickOneStar(_ sender: Any) {
        let stars = 1
        itunesWrapper.setCurrentNumberOfStars (total:stars)
        updateViewStars (value:stars)
    }
    
    @IBAction func clickTwoStar(_ sender: Any) {
        let stars = 2
        itunesWrapper.setCurrentNumberOfStars (total:stars)
        updateViewStars (value:stars)
        
    }
    @IBAction func clickThreStar(_ sender: Any) {
        let stars = 3
        itunesWrapper.setCurrentNumberOfStars (total:stars)
        updateViewStars (value:stars)
        
    }
    @IBAction func clickFourStar(_ sender: Any) {
        let stars = 4
        itunesWrapper.setCurrentNumberOfStars (total:stars)
        updateViewStars (value:stars)
    }
    
    @IBAction func clickFiveStar(_ sender: Any) {
        let stars = 5
        itunesWrapper.setCurrentNumberOfStars (total:stars)
        updateViewStars (value:stars)
    }
    
    
    @IBAction func clickHeart(_ sender: Any) {
        itunesWrapper.setCurrentSongLoved(value: !itunesWrapper.isCurrentSongLoved())
        self.updateViewHeart(isLoved: itunesWrapper.isCurrentSongLoved())
    }
    
    @IBAction func quit(_ sender: Any) {
        os_log ("Exiting..")
        NSApplication.shared.terminate(self)
    }

    @IBAction func clickNextTrack(sender: Any) {
        itunesWrapper.nextTrack()
    }
    
    @IBAction func clickPreviousTrack(sender: Any) {
        itunesWrapper.previousTrack()
    }
    
    @IBAction func clickPlayPauseTrack(sender: Any) {
        itunesWrapper.playPause()
    }
}

extension QuickRatingViewController {
    
    // MARK : Notifications
    func observePlayerInfoNotification() {
        DistributedNotificationCenter.default().addObserver(
            self,
            selector: #selector(playerInfoChanged(_:)),
            name: NSNotification.Name.iTunesPlayerInfo, object: nil)
    }
    
    func removePlayerInfoNotification() {
        DistributedNotificationCenter.default().removeObserver(self)
    }
    
    @objc func playerInfoChanged(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo,
            let playerState = userInfo["Player State"] as? String
            else { return }
        
        self.updatePlayPauseButton(playerState: playerState)
    }
}
