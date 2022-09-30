import Foundation

struct SportsList: Codable {
    let sports: [Sport]
}

struct Sport: Codable {
    let id: Int
    let name: String
}
