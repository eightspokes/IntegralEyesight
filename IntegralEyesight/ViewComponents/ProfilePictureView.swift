//
//  ProfilePictureView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/25/23.
//

import SwiftUI

/// A view to display a profile picture with an optional circular gradient border.
struct ProfilePictureView: View {
    /// The name of the image to be displayed.
    var image: String?
    
    /// Computed property that returns the actual image name to be used.
    var profileImage: String {
        if let image = image {
            return image
        }
        return "default-icon"
    }
    
    var body: some View {
        VStack {
            Image(profileImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 65, height: 65)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .strokeBorder(
                            AngularGradient(gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]), center: .center, startAngle: .zero, endAngle: .degrees(360)),
                            lineWidth: 2)
                )
        }
    }
}

#Preview {
    ProfilePictureView(image: "ProfilePicture")
}
