//
//  Global.swift
//  iTunesQuickRatingBar
//
//  Created by Rodrigo Villamil Pérez on 25/12/2018.
//  Copyright © 2018 Rodrigo Villamil Pérez. All rights reserved.
//

import Foundation

// MARK: - Global Var

extension Notification.Name {
    static let iTunesPlayerInfo = Notification.Name("com.apple.iTunes.playerInfo")
 }

// MARK: - Global Method Replacement

#if !DEBUG
    func NSLog(_ format: String, _ args: CVarArg...) {}
    func print(_ item: Any) {}
#endif
