//
//  iTunesWrapper.swift
//  iTunesQuickRatingBar
//
//  Created by Rodrigo Villamil Pérez on 25/12/2018.
//  Copyright © 2018 Rodrigo Villamil Pérez. All rights reserved.
//

import Foundation
import ScriptingBridge
import Cocoa
import os

class iTunesWrapper {
    
    // MARK: Constants
    static let DEFAULT_TEXT = "Not available"
    
    // MARK: Variables
    var app: iTunesApplication
    
    init() {
        app = SBApplication(bundleIdentifier: "com.apple.iTunes")!
    }
    
    func valueFilled (value:String?) -> String {
        var text = value ?? iTunesWrapper.DEFAULT_TEXT
        if (text.isEmpty) {
            text = iTunesWrapper.DEFAULT_TEXT
        }
        return text
    }
    
    func isApplicationRunning() -> Bool{
        if app.isRunning {
            os_log ("iTunes is running")
        } else {
            os_log ("iTunes is not running")
        }
        return app.isRunning
    }
    
    func currentTitle() -> String {
        let currentTrack: iTunesTrack? = app.currentTrack
        return valueFilled(value: currentTrack?.name)
    }
    
    func currentArtist() -> String {
        let currentTrack: iTunesTrack? = app.currentTrack
        return valueFilled(value: currentTrack?.artist)
    }
    
    func currentAlbum() -> String {
        let currentTrack: iTunesTrack? = app.currentTrack
        return valueFilled(value: currentTrack?.album)
    }
    
    func currentRating() -> Int {
        let currentTrack: iTunesTrack? = app.currentTrack
        return (currentTrack?.rating)!
    }
    
    func setCurrentRating(value: Int) {
        let currentTrack: iTunesTrack? = app.currentTrack
        currentTrack?.setRating!(value)
    }
    
    func isCurrentSongLoved() -> Bool {
        let currentTrack: iTunesTrack? = app.currentTrack
        return (currentTrack?.loved)!
    }
    
    func setCurrentSongLoved(value: Bool)  {
        let currentTrack: iTunesTrack? = app.currentTrack
        currentTrack?.setLoved!(value)
    }
    
    func currentNumberOfStars() -> Int {
        return self.currentRating() / 20
    }
    
    func setCurrentNumberOfStars(total: Int) {
        self.setCurrentRating (value: total * 20)
    }
    
    func currentLyric() -> String?  {
        let currentTrack: iTunesTrack? = app.currentTrack
        return (currentTrack?.lyrics)
    }
    
    func currentFirstCover() -> NSImage?  {
       
        let artWorks: SBElementArray? = app.currentTrack?.artworks!()
        var firstCover:NSImage?
    
        for artWork in artWorks! {
            let currentArtwork = (artWork as! iTunesArtwork)
            if let rawDataImage = currentArtwork.rawData {
                firstCover = NSImage(data: rawDataImage)
                break;
            }
        }
        return firstCover
    }
    
    func playPause() {
        app.playpause!();
    }
    
    func nextTrack() {
        app.nextTrack!();
    }
   
    func previousTrack() {
        app.previousTrack!();
    }
    
    func playerState() -> iTunesEPlS {
        return app.playerState!;
    }
    
    func logCurrentSongInfo () {
        os_log("Title: %@, Artist: %@, Album: %@, Rating: %d",
               self.currentTitle(),
               self.currentArtist(),
               self.currentAlbum(),
               self.currentRating())
    }
}

