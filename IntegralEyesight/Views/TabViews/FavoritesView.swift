//
//  FavoritesView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/19/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoriteVideosViewModel

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(favorites.favoriteVideos, id: \.name) { video in
                    NavigationLink {
                        VideoView(video: video)
                    } label: {
                        VideoCardView(video: video)
                    }
                }
            }
            .navigationTitle("Favorite Videos")
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(FavoriteVideosViewModel())
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)

}
