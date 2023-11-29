//
//  AnnouncementView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/25/23.
//

import SwiftUI

struct AnnouncementView: View {
    @Environment(\.colorScheme) var colorScheme
    let titleText: String
    let bodyText: String
    
    var body: some View {
        ZStack(alignment: .topLeading) { // Aligns children to the top leading corner
            Rectangle()
                .foregroundColor( colorScheme == .dark ? ColorTheme.backgroundColor.lighter(by: 20) : ColorTheme.backgroundColor.darker(by: 20)) // Gives the rectangle a color to be visible
                .frame(height: 130)
                .cornerRadius(10)
                .padding()
            
            VStack(alignment: .leading) {
                
                
                Text(titleText)
                    .font(.headline).bold()
                
                Text(bodyText)
                
                HStack{
                    Spacer()
                    Button{
                        
                    }label: {
                        Text("Register")
                            .bold()
                            .frame(width: 150, height: 25)
                    }
                    Spacer()
                }
                .buttonStyle(.borderedProminent)
                .tint(.pink)
                
            }
            .padding([.top, .leading, .trailing], 25)
        }
    }
}

#Preview {
    AnnouncementView(titleText: "Registration for the next Vision Tune Up series is now open!", bodyText: "November 1st – 30th, 2023")
        .preferredColorScheme(.dark)
}

