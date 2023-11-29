//
//  ContentView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/11/23.
//

import SwiftUI

enum Theme {
    static let primary = Color("Primary")
}

struct BaseView: View {

    var body: some View {

        
        TabView{
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "calendar")
                }
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }


        }
            .accentColor(ColorTheme.textColor)
    }
}

#Preview {
    Group{
        BaseView()
            .environmentObject(VimeoViewModel(service: VimeoService()))
            .environmentObject(FavoriteVideosViewModel())
            .preferredColorScheme(.dark)
        
    }
}
