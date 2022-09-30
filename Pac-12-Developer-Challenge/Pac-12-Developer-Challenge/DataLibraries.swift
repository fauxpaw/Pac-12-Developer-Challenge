import Foundation
import UIKit

struct SchoolsLibrary: AppModelLibrary {
    private let schools: [School]
    
    init(schools: [School]) {
        self.schools = schools
    }
    
    func name(id: Int) -> String {
        return schools.first { $0.id == id}?.name ?? "mystery school"
    }
}

struct SportsLibrary: AppModelLibrary {
    private let sports: [Sport]
    
    init(sports: [Sport]) {
        self.sports = sports
    }
    
    func name(id: Int) -> String {
        return sports.first { $0.id == id}?.name ?? "mystery sport"
    }
}
