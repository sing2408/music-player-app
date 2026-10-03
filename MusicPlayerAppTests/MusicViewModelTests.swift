//
//  MusicViewModelTests.swift
//  MusicPlayerAppTests
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import XCTest

@testable import MusicPlayerApp

@MainActor
final class MusicViewModelTests: XCTestCase {
    
    private var mockService: MockMusicService! = nil
    private var mockSoundManager: MockSoundManager! = nil
    private var vm: MusicViewModel! = nil
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockMusicService()
        mockSoundManager = MockSoundManager()
        vm = MusicViewModel(service: mockService, soundManager: mockSoundManager)
    }
    
    override func tearDownWithError() throws {
        vm = nil
        mockService = nil
        mockSoundManager = nil
        try super.tearDownWithError()
    }
    
    func testGivenIsPaused_whenPressPause_thenShouldPause() throws {
        // Given
        mockSoundManager.isPaused = true
        // When
        vm.pauseMusic()
        // Then
        XCTAssertFalse(mockSoundManager.isPausedMock)
    }
    
    func testGivenIsPlayed_whenPressPause_thenShouldPause() throws {
        // Given
        mockSoundManager.isPaused = false
        // When
        vm.pauseMusic()
        // Then
        XCTAssertTrue(mockSoundManager.isPausedMock)
    }
    
    func testGivenParam_whenFetchMusicList_thenReturnMusicList() async throws {
        // Given
        let param = "test Artist"
        // When
        
        await vm.fetchMusicList(param: param)
        XCTAssertEqual(vm.musicList?.results?[0].artistName, "mockartist")
        
    }
    
    func testGivenParam_whenFetchMusicList_thenReturnError() async throws {
        // Given
        let param = "test Artist"
        mockService.shouldThrow = true
        // When
        
        await vm.fetchMusicList(param: param)
        // Then
        XCTAssertTrue(vm.isError)
        
    }
    
    func testGivenBack_whenBackMusic_thenPlayBack() {
        // Given
        mockSoundManager.isPaused = true
        // When
        
        vm.append(music: Music(trackId: 123, artistName: "mockartist", trackName: "mocktrack", artworkUrl30: "mockart", previewUrl: "mockpreview", trackTimeMillis: 123))
        vm.playMusicLast()
        vm.backMusic()
        // Then
        XCTAssertTrue(mockSoundManager.isPlayMock)
    }
    
    func testGivenNext_whenNextMusic_thenPlayForward() {
        // Given
        mockSoundManager.isPaused = true
        // When
        vm.append(music: Music(trackId: 123, artistName: "mockartist", trackName: "mocktrack", artworkUrl30: "mockart", previewUrl: "mockpreview", trackTimeMillis: 123))
        vm.playMusicLast()
        vm.nextMusic()
        // Then
        XCTAssertTrue(mockSoundManager.isPlayMock)
    }
    
    func testGivenPlayMusicLast_whenPlayMusicLast_thenPlayLast() {
        // Given
        mockSoundManager.isPaused = true
        // When
        vm.append(music: Music(trackId: 123, artistName: "mockartist", trackName: "mocktrack", artworkUrl30: "mockart", previewUrl: "mockpreview", trackTimeMillis: 123))
        vm.playMusicLast()
        vm.backMusic()
        // Then
        XCTAssertTrue(mockSoundManager.isPlayMock)
    }
}
