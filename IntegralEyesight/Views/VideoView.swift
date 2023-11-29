//
//  VideoView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/26/23.
//
import SwiftUI
import AVKit
import AVFoundation
struct VideoView: View {
    var video: Video
    @State private var player = AVPlayer()
    @EnvironmentObject var vimeoViewModel: VimeoViewModel
    @EnvironmentObject var favorites: FavoriteVideosViewModel


    var body: some View {

        ZStack(alignment: .topLeading) {
            VideoPlayer(player:player)
                .edgesIgnoringSafeArea(.all)
                .onAppear{

                    if let link = vimeoViewModel.getLink(for: video, withQuality: "sd", andRendition: "360p"){
                        player = AVPlayer(url: URL(string: link)!)
                        let playerViewController = AVPlayerViewController()
                        playerViewController.player = player
                        player.play()
                    }
            }

            Button{

                if favorites.contains(video){
                    favorites.remove(video)
                }else{
                    favorites.add(video)
                }
            }label: {
                Group {
                            if favorites.contains(video) {
                                Image(systemName: "heart.fill")
                                   .foregroundColor(.red)
                            } else {
                                    Image(systemName: "heart")
                                        .foregroundColor(.red)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical,5)
                        .font(.title)
                        .transition(.scale) // Transition effect for both states
                        .animation(.easeInOut(duration: 0.3), value: favorites.contains(video))
            }
        }
    }
}

#Preview {
    VideoView(video: Video.ExampleVideo)
        .environmentObject(VimeoViewModel(service: VimeoService()))
}
