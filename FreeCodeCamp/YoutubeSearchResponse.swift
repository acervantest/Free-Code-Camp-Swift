//
//  YoutubeSearchResponse.swift
//  FreeCodeCamp
//
//  Created by Alejandro Cervantes on 2025-11-17.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}

struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
