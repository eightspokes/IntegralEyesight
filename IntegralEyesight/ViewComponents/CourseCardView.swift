//
//  CourseCard.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/24/23.
//

import SwiftUI

struct CourseCard: View {
    let cornerRadius = 15
    var cardImage: String
    let description: String = "This is a description of the course. It can be two to three sentences long. It should describe what this course is about."
    
    var body: some View {
        VStack(alignment: .leading){
            Image( cardImage)
                .resizable()
                .scaledToFit()
                .cornerRadius(CGFloat(cornerRadius))
            Text(description)
                .padding(.horizontal)
                .font(.callout)
                .foregroundColor(ColorTheme.textColor)
        }
    }
}
#Preview {
    CourseCard(cardImage: "Instructional Videos")
}
