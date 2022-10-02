import Foundation
import UIKit

private let reuseIdentifier = "VodCard"

// I had hoped to get the prefetching up and running for this view so that I could also meet the bonus requirement but would need more time for that

class CustomDataSource: NSObject, UICollectionViewDataSource,  UICollectionViewDataSourcePrefetching {
        
    var currentVods: VodList?
    var schoolsLib: SchoolsLibrary?
    var sportsLib: SportsLibrary?
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentVods?.programs.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? VODCell, let vod = currentVods?.programs[indexPath.row], let sportsLib = sportsLib, let schoolsLib = schoolsLib else { return UICollectionViewCell() }
        cell.configureView(with: vod, sportsLib: sportsLib, schoolsLib: schoolsLib)
        return cell
    }
    
    // MARK: UICollectionViewDataSourcePrefetching
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
    }
}
