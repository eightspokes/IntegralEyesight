//
//  IntegralEyesightApp.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/11/23.
//

import SwiftUI

@main
struct IntegralEyesightApp: App {
    
    @StateObject var vimeoViewModel = VimeoViewModel(service: VimeoService())
    @StateObject var favorites = FavoriteVideosViewModel()
    var body: some Scene {
        WindowGroup {
            BaseView()
                .preferredColorScheme(.dark)
                .environmentObject(vimeoViewModel)
        }       .environmentObject(favorites)
    }
}
