//
//  CourseDetailedView.swift
//  IntegralEyesight
//
//  Created by Roman Kozulia on 11/26/23.
//

import SwiftUI


struct CourseDetailedView: View {
    @EnvironmentObject var vimeoViewModel: VimeoViewModel
    @State var courseVideos: [VideoItem] = []
    let courseName: String
    let videosUri: String
    var body: some View {
        NavigationStack {
            Text("These videos will help you to understand the fundamentals of natural vision improvement")
                .padding()
            ScrollView {
                ForEach(courseVideos, id: \.video.name){ video in
                    NavigationLink{
                        VideoView(video: video.video)
                    }label: {
                        VideoCardView(video: video.video)
                    }
                }
                
            }.task {
                do{
                    try courseVideos = await vimeoViewModel.fetchVideosInCourseFolder(from: videosUri)
                }catch {
                    print("Error!!: \(error)")
                }
                
            }
            .navigationTitle(courseName)
        }
    }
}
#Preview {
    CourseDetailedView(courseName: "Instructional Videos", videosUri: "users/47826142/projects/18611365")
        .environmentObject(VimeoViewModel())
}
