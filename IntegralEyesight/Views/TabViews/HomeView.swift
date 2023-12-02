//
//  HomeView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/19/23.
//

import SwiftUI

struct HomeView: View {
    let announcementTitle = "Registration for the next Vision Tune Up series is now open!"
    let announcementBody = "November 1st – 30th, 2023"
    @State var isRegisteredForEvent = false


    @EnvironmentObject var vimeoViewModel: VimeoViewModel
    // Environment property to detect the color scheme
    @Environment(\.colorScheme) var colorScheme

    var body: some View {

        NavigationStack {
            ZStack{
                ColorTheme.backgroundColor.ignoresSafeArea()
                //App logo and Profile picture
                VStack {
                    ProfileView()
                    if !isRegisteredForEvent{
                        AnnouncementView(isRegistered: $isRegisteredForEvent, titleText: announcementTitle, bodyText: announcementBody)

                        if !vimeoViewModel.isFetchFoldersInRootLoading {
                            ScrollView(.vertical) {
                                ForEach(vimeoViewModel.foldersInRootFolder, id: \.name){ folder in
                                    if folder.name != "Legal Disclaimer"{
                                        NavigationLink{
                                            CourseDetailedView(courseName: folder.name, videosUri: folder.uri)
                                        } label: {
                                            VStack(alignment: .leading){
                                                Text(folder.name)
                                                    .font(.title)
                                                    .foregroundColor(ColorTheme.textColor)
                                                CourseCard(cardImage: folder.name)
                                            }

                                        }
                                    }
                                }

                            }.padding(.horizontal)


                        }else{
                            ProgressView()
                            Spacer()
                        }
                    }
                }
                .task {
                    do{
                        try await vimeoViewModel.fetchFoldersInRootFolder()
                    }catch{
                        print("Error fetching folders from Vimeo API\(error.localizedDescription)")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(VimeoViewModel(service: VimeoService()))
        .preferredColorScheme(.dark)

}


