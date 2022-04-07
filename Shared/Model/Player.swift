//
//  Player.swift
//  NBA-IOS-App
//
//  Created by Willy Merlet on 21/03/22.
//

import Foundation

struct Player: Identifiable, Codable {
    var id = UUID().uuidString
    var name: String
    var image: String
    var position: String
    var team: String
}
