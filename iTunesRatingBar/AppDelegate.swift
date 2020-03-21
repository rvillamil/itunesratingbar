//
//  AppDelegate.swift
//  iTunesQuickRatingBar
//
//  Created by Rodrigo Villamil Pérez on 09/12/2018.
//  Copyright © 2018 Rodrigo Villamil Pérez. All rights reserved.
//

import Cocoa
import os

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // https://www.raywenderlich.com/450-menus-and-popovers-in-menu-bar-apps-for-macos
    // This creates a Status Item — aka application icon — in the menu bar
    // with a fixed length that the user will see and use
    let statusItem = NSStatusBar.system.statusItem(
        withLength:NSStatusItem.squareLength)
    let popover = NSPopover()
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = QuickRatingViewController.freshController()
    }
  
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
   
    @objc func togglePopover(_ sender: Any?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: Any?) {
        popover.performClose(sender)
    }
}

