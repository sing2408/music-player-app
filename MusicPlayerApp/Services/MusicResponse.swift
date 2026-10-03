//
//  MusicResponse.swift
//  MusicPlayerApp
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import Foundation

struct MusicResponse: Codable {
    let resultCount: Int?
    let results: [Music]?
}

struct Music: Codable, Equatable {
    let trackId: Int?
    let artistName: String?
    let trackName: String?
    let artworkUrl30: String?
    let previewUrl: String?
    let trackTimeMillis: Int?
}
