//
//  RadioViewModel.swift
//  Bible
//
//  Created by GoEun Jeong on 2021/11/04.
//  Copyright © 2021 jge. All rights reserved.
//

import Foundation
import FRadioPlayer
import MediaPlayer
import Kingfisher

public class RadioViewModel: ObservableObject {
    @Published public var track = Track(title: "", artist: "")
    @Published public var isLoaded = false
    @Published public var isPlaying = false
    
    private let player = FRadioPlayer.shared
    
    public init() {
        UIApplication.shared.beginReceivingRemoteControlEvents()
        player.delegate = self
        player.radioURL = URL(string: "http://base2.rush79.com:9200")
        player.isAutoPlay = false
        player.enableArtwork = true
        player.artworkSize = 500
    }
    
    public func toggle() {
        player.togglePlaying()
        self.isPlaying.toggle()
    }
}

extension RadioViewModel: FRadioPlayerDelegate {
    public func radioPlayer(_ player: FRadioPlayer, playerStateDidChange state: FRadioPlayerState) {
        switch state {
        case .loading:
            print("loading station...")
        case .urlNotSet:
            print("Station URL isn't invalid.")
        case .readyToPlay, .loadingFinished:
            self.setupRemoteCommandCenter()
            print("station okay")
            self.isLoaded = true
            return
        case .error:
            print("error playing")
        }
    }
    
    public func radioPlayer(_ player: FRadioPlayer, playbackStateDidChange state: FRadioPlaybackState) {
    }
    
    public func radioPlayer(_ player: FRadioPlayer, artworkDidChange artworkURL: URL?) {
        if let url = artworkURL {
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let imageResult):
                    self.track.artworkImage = imageResult.image
                case .failure:
                    self.track.artworkImage = UIImage(named: "jesus")
                }
            }
            updateLockScreen(artworkURL: url, artistName: self.track.artist, trackName: self.track.title)
        } else {
            self.track.artworkImage = UIImage(named: "jesus")
            updateLockScreen(artworkURL: URL(string: "https://i1.wp.com/www.cssscript.com/wp-content/uploads/2014/10/iOS-OS-X-Style-Pure-CSS-Loading-Spinner.jpg?fit=400%2C300&ssl=1"), artistName: self.track.artist, trackName: self.track.title)
        }
    }
    
    public func radioPlayer(_ player: FRadioPlayer, metadataDidChange artistName: String?, trackName: String?) {
        self.track.title = trackName ?? ""
        self.track.artist = artistName ?? ""
    }
}

public extension RadioViewModel {
    //*****************************************************************
    // MARK: - Remote Command Center Controls
    //*****************************************************************
    
    func setupRemoteCommandCenter() {
        // Get the shared MPRemoteCommandCenter
        let commandCenter = MPRemoteCommandCenter.shared()
        
        // Add handler for Play Command
        commandCenter.playCommand.addTarget { _ in
            self.isPlaying = true
            self.player.play()
            return .success
        }
        
        // Add handler for Pause Command
        commandCenter.pauseCommand.addTarget { _ in
            self.isPlaying = false
            self.player.pause()
            return .success
        }
    }
    
    func updateLockScreen(artworkURL: URL?, artistName: String?, trackName: String?) {
        print("updateLockScreen")
        // Define Now Playing Info
        var nowPlayingInfo = [String: Any]()
        
        if let url = artworkURL {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { (data: Data?, _, _) in
                guard let data = data else { return }
                
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: UIImage(data: data)!.size, requestHandler: { _ -> UIImage in
                    return UIImage(data: data)!
                })
            }.resume()
        } else {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: UIImage(named: "jesus")!.size, requestHandler: { _ -> UIImage in
                return UIImage(named: "jesus")!
            })
        }
        
        if let artist = artistName {
            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
        }
        
        if let title = trackName {
            nowPlayingInfo[MPMediaItemPropertyTitle] = title
        }
        
        // Set the metadata
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
}
