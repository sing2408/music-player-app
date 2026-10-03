//
//  MockSoundManager.swift
//  MusicPlayerAppTests
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import Foundation

final class MockSoundManager: SoundManagerProtocol {
    
    var isPlayMock = false
    var isPausedMock = false
    
    var isPaused: Bool = true
    
    func playSound(url: String) {
        isPlayMock = true
    }
    
    func pause() {
        if isPaused {
            isPlayMock = true
        } else {
            isPausedMock = true
        }
        isPaused.toggle()
    }
}

