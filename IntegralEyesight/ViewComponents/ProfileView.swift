//
//  ProfileView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/26/23.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) var colorScheme
    let title = "Integral Eyesight\nImprovement"
    var body: some View {
        HStack(alignment: .bottom){
            
            Image(colorScheme == .dark ? "AppIconWhite" : "AppIconBlack")
                .resizable()
                .scaledToFit()
                .frame(width: 65)
            Text(title)
                .lineSpacing(-2)
                .bold()
                .italic()
            Spacer()
            ProfilePictureView(image: "ProfilePicture")
        }
        .padding(.vertical,10)
        .padding(.horizontal,20)
    }
}

#Preview {
    ProfileView()
}
