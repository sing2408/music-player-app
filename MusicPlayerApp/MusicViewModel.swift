//
//  MusicViewModel.swift
//  MusicPlayerApp
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import SwiftUI
import Combine

@MainActor
final class MusicViewModel: ObservableObject {
    private let service: MusicService
    private let soundManager: SoundManagerProtocol
    
    @Published var musicList: MusicResponse?
    @Published var musicQueue: [Music] = []
    @Published var isError: Bool = false
    private var index: Int = 0
    
    init(
        service: MusicService = MusicServiceAPI(),
        soundManager: SoundManagerProtocol = SoundManager()
    ) {
        self.service = service
        self.soundManager = soundManager
    }
    
    func fetchMusicList(param: String) async {
        do {
            musicList = try await self.service.fetchMusicList(param: param)
        } catch {
            isError = true
        }
    }
    
    func append(music: Music) {
        self.musicQueue.append(music)
    }
    
    func backMusic() {
        if index == 0 { return }
        index -= 1
        soundManager.playSound(url: musicQueue[index].previewUrl ?? "")
    }
    
    func nextMusic() {
        if index == musicQueue.count - 1 { return }
        index += 1
        soundManager.playSound(url: musicQueue[index].previewUrl ?? "")
    }
    
    func playMusicLast() {
        soundManager.playSound(url: musicQueue.last?.previewUrl ?? "")
        if index == 0 { index += 1 }
        index = musicQueue.count - 1
    }
    
    func pauseMusic() {
        soundManager.pause()
    }
}
