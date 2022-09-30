import Foundation

protocol AppModelLibrary {
    func name(id: Int) -> String
}

protocol IdNameRepresentable {
    func getName(lib: AppModelLibrary) -> String
}

struct VodSchool: Codable, IdNameRepresentable {
    let id: Int
    
    public func getName(lib: AppModelLibrary) -> String {
        return lib.name(id: id)
    }
}

struct VodSport: Codable, IdNameRepresentable {
    let id: Int
    
    func getName(lib: AppModelLibrary) -> String {
        return lib.name(id: id)
    }
}

struct VodList: Codable {
    let programs: [Vod]
    let nextPage: URL
}

struct VodImagesList: Codable {
    let small: URL
}

struct Vod: Codable {
    
    let schools: [VodSchool]?
    let sports: [VodSport]?
    let duration: Double
    let title: String
    let url: URL
    let images: VodImagesList
}
