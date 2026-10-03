//
//  MockMusicService.swift
//  MusicPlayerAppTests
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import Foundation
import SwiftUI

final class MockMusicService: MusicService {
    var shouldThrow = false
    func fetchMusicList(param: String) async throws -> MusicResponse {
        if shouldThrow {
            throw MockError.mockFailure
        } else {
            return MusicResponse(resultCount: 1, results: [Music(trackId: 123, artistName: "mockartist", trackName: "mocktrack", artworkUrl30: "mockart", previewUrl: "mockpreview", trackTimeMillis: 123)])
        }
    }
}

enum MockError: Error {
    case mockFailure
}
