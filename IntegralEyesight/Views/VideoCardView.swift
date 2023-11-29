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
    @State var  image: UIImage?
    var body: some View {
        ZStack {
            ZStack(alignment: .bottomLeading){
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(height: 400)
                    .cornerRadius(30)
                    .padding(.horizontal,30)
                if let image {
                    Image(uiImage: image)
                }else{
                    // Text("Image in nil")
                }
                Text(video.name)
                    .padding(.horizontal,50)
                    .padding(.vertical,20)
            }
            .task{
                do{
                    image = try await vimeoViewModel.getImage(url: sampleImageUrl)
                }catch{
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
