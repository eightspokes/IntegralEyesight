import Foundation

//Structure we expect when we try to get data from the root Vimeo Folder
struct RootFolderResponse: Codable {
    let total: Int
    let page: Int
    let perPage: Int
    let paging: Paging
    let data: [FolderData]

    enum CodingKeys: String, CodingKey {
        case total, page, data, paging
        case perPage = "per_page"
    }
}

struct Paging: Codable {
    let next: String?
    let previous: String?
    let first: String
    let last: String
}

struct FolderData: Codable {
    let type: String
    let folder: Folder
}

struct Folder: Codable {
    let createdTime: String
    let modifiedTime: String
    let lastUserActionEventDate: String
    let name: String
    let privacy: Privacy
    let resourceKey: String
    let uri: String
    // Include other fields if necessary

    enum CodingKeys: String, CodingKey {
        case createdTime = "created_time"
        case modifiedTime = "modified_time"
        case lastUserActionEventDate = "last_user_action_event_date"
        case name, privacy, uri
        case resourceKey = "resource_key"
        // Map other fields as needed
    }
}

struct Privacy: Codable {
    let view: String
}

//Structure we expect when we try to get videos from a folder that contains Course materials
struct VideosOfACourseResponse: Codable {
    let total: Int
    let page: Int
    let perPage: Int
    let paging: Paging
    let data: [VideoItem]

    enum CodingKeys: String, CodingKey {
        case total, page, data
        case perPage = "per_page"
        case paging
    }
}

struct VideoItem: Codable {
    let type: String
    let video: Video
}

struct File: Codable, Hashable {
    let quality: String
    let rendition: String
    let type: String
    let width: Int?
    let height: Int?
    let link: String
    let fps: Int?
    let size: Int?
    let md5: String?
}

struct Video: Codable, Hashable {
    let uri: String
    let name: String
    let description: String?
    let type: String
    let link: String
    let files: [File]?

    static let ExampleVideo: Video = Video(uri: "/videos/158064921", name: "Pinhole Glasses", description: "This video shows you how to use pinhole glasses to help you see more clearly near and far and how they can increase the rate that your eyes shift.", type: "video", link: "https://player.vimeo.com/progressive_redirect/playback/158064921/rendition/1080p/file.mp4?loc=external&oauth2_token_id=1751395057&signature=57bf99cd0550506f33348ecfa32335b18ef9ff8e4f582f3de5e0662efee761a5", files: nil)

    static func ==(lhs: Video, rhs: Video) -> Bool {
        lhs.uri == rhs.uri
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uri)
    }
}

struct Embed: Codable {
    let html: String
}
