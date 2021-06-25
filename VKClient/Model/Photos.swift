import Foundation

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
struct Photo: Codable {
    let albumID, id, ownerID: Int
    let sizes: [Size]
    let likes: Likes

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id
        case ownerID = "owner_id"
        case sizes, likes
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
struct Size: Codable {
    let url: String
    let type: String
}
