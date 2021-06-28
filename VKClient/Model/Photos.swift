import Foundation
import RealmSwift

// MARK: - Welcome
struct Photos: Codable {
    let response: ResponsePhotos
}

// MARK: - Response
struct ResponsePhotos: Codable {
    let count: Int
    let items: [Photo]
}

// MARK: - Item
class Photo: Object, Codable {
    @objc dynamic var albumID: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var ownerID: Int = 0
    dynamic var sizes: [Size]
    dynamic var likes: Likes

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
    
    override static func ignoredProperties() -> [String] {
        return ["sizes", "likes"]
    }
}

// MARK: - Likes
class Likes: Object, Codable {
    @objc dynamic var count: Int = 0
    @objc dynamic var userLikes: Int = 0

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
class Size: Object, Codable {
    @objc dynamic var url: String = ""
    @objc dynamic var type: String = ""
}
