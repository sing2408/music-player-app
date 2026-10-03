//
//  Services.swift
//  MusicPlayerApp
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import Foundation

protocol MusicService {
    func fetchMusicList(param: String) async throws -> MusicResponse
}

final class MusicServiceAPI: MusicService {
    func fetchMusicList(param: String) async throws -> MusicResponse {
        let url = URL(string: "https://itunes.apple.com/search?term={\(param)}")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(MusicResponse.self, from: data)
    }
}
