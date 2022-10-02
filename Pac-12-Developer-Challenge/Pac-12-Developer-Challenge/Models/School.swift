import Foundation

struct SchoolsList: Codable {
    let schools: [School]
}

struct School: Codable {
    let id: Int
    let name: String
}
