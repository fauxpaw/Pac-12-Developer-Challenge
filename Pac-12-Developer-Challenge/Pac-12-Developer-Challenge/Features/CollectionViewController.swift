import UIKit


class CollectionViewController: UICollectionViewController {
    
    let api = API()
    private var dataSource = CustomDataSource()
    var isFetching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = dataSource
        
        api.getSchools { [weak self] result in
            switch result {
            case .success(let schoolsList):
                self?.dataSource.schoolsLib = SchoolsLibrary(schools: schoolsList.schools)
                self?.fetchSports()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
        
    private func fetchSports() {
        api.getSports { [weak self] result in
            switch result {
            case .success(let sportsList):
                self?.dataSource.sportsLib = SportsLibrary(sports: sportsList.sports)
                self?.fetchInitialVods()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchInitialVods() {
        api.getVods {[weak self] result in
            switch result {
            case .success(let response):
                self?.dataSource.currentVodList = response
                self?.dataSource.vods.append(contentsOf: response.programs)
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchSubsequentVods(route: String) {
        api.getVods(route: route) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSource.currentVodList = data
                self?.dataSource.vods.append(contentsOf: data.programs)
                self?.isFetching = false
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
                self?.isFetching = false
            }
        }
    }
    
    // MARK: UIScrollViewDelegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.isAtBottom && dataSource.currentVodList != nil && !isFetching {
            isFetching = true
            if let route = dataSource.currentVodList?.nextPage {
                fetchSubsequentVods(route: route)
            }
            
        }
    }
}

//https://stackoverflow.com/questions/7706152/check-if-a-uiscrollview-reached-the-top-or-bottom
extension UIScrollView {
    
    var verticalOffsetForBottom: CGFloat {
            let scrollViewHeight = bounds.height
            let scrollContentSizeHeight = contentSize.height
            let bottomInset = contentInset.bottom
            let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
            return scrollViewBottomOffset
        }
    
    var isAtBottom: Bool {
            return contentOffset.y >= verticalOffsetForBottom
        }
}
