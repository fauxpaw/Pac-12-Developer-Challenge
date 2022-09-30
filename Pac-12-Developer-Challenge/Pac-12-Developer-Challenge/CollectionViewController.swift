import UIKit


class CollectionViewController: UICollectionViewController {
    
    let api = API()
    private var dataSource = CustomDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = dataSource
        self.collectionView.prefetchDataSource = dataSource
        
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
                self?.fetchVods()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchVods() {
        api.getVods {[weak self] result in
            switch result {
            case .success(let response):
                dump(response)
                self?.dataSource.currentVods = response
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
