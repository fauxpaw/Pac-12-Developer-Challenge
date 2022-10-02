import Foundation
import UIKit

private let reuseIdentifier = "VodCard"

class CustomDataSource: NSObject, UICollectionViewDataSource {
    
    var currentVodList: VodList?
    var vods = [Vod]()
    var schoolsLib: SchoolsLibrary?
    var sportsLib: SportsLibrary?
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? VODCell, let sportsLib = sportsLib, let schoolsLib = schoolsLib else { return UICollectionViewCell() }
        let vod = vods[indexPath.row]
        cell.configureView(with: vod, sportsLib: sportsLib, schoolsLib: schoolsLib)
        return cell
    }
}
