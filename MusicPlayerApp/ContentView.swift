//
//  ContentView.swift
//  MusicPlayerApp
//
//  Created by Singgih Tulus Makmud on 03/10/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = MusicViewModel()
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            TextField("Search Artist", text: $searchText)
                .onChange(of: searchText) { _, newValue in
                    Task {
                        await vm.fetchMusicList(param: newValue)
                    }
                }
            List {
                ForEach(vm.musicList?.results ?? [], id: \.trackId) { result in
                    musicCell(item: result)
                }
            }
            HStack(alignment: .center) {
                Image("back_music")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        vm.backMusic()
                    }
                
                Image("pause_music")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        vm.pauseMusic()
                    }
                
                Image("forward_music")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        vm.nextMusic()
                    }
                
            }
        }
        .padding()
        .task {
            await vm.fetchMusicList(param: searchText)
        }
    }
    
    @ViewBuilder
    private func musicCell(item: Music) -> some View {
        HStack {
            AsyncImage(url: URL(string: item.artworkUrl30 ?? "")) { image in
                image
                    .resizable()
                    .frame(width: 30, height: 30)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(item.trackName ?? "-")
                Text(item.artistName ?? "-")
                Text(item.trackName ?? "-")
            }
            
            Spacer()
            
            if item == vm.musicQueue.last {
                Image("play_music")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }
        .onTapGesture {
            vm.append(music: item)
            vm.playMusicLast()
        }
    }
}

#Preview {
    ContentView()
}
