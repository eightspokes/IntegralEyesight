//
//  VideoCardView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/26/23.
//

import SwiftUI

struct VideoCardView: View {
    var video: Video
    let sampleImageUrl = "/users/47826142/pictures/11187135"
    @EnvironmentObject var vimeoViewModel: VimeoViewModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @State var image: UIImage?

    var body: some View {
        let isLandscape = horizontalSizeClass == .regular && verticalSizeClass == .compact
        let frameHeight: CGFloat = isLandscape ? 280 : 400 // 30% smaller in landscape

        ZStack {
            ZStack(alignment: .bottomLeading) {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(height: frameHeight)
                    .cornerRadius(30)
                    .padding(isLandscape ? .horizontal : .all)

                Image(video.name)
                    .resizable()
                    .scaledToFit()
                    .frame(height: frameHeight)
                    .cornerRadius(30)
                    .padding(isLandscape ? .horizontal : .all)

                Text(video.name)
                    .padding(.horizontal, 50)
                    .padding(.vertical, 20)
            }
            .task {
                do {
                    image = try await vimeoViewModel.getImage(url: sampleImageUrl)
                } catch {
                    print("Error getting image")
                }
            }

            Image(systemName: "play.fill")
                .foregroundStyle(.white)
                .font(.title)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(50)
        }
    }
}


#Preview {
    VideoCardView(video: Video.ExampleVideo)
        .environmentObject(VimeoViewModel(service: VimeoService()))
    
}
