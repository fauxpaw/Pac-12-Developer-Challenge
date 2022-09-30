import UIKit

private let reuseIdentifier = "VodCard"

class CollectionViewController: UICollectionViewController {
    
    var api = API()
    var currentVods: VodList?
    var schoolsLib: SchoolsLibrary?
    var sportsLib: SportsLibrary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api.getSchools { [weak self] result in
            switch result {
            case .success(let schoolsList):
                self?.schoolsLib = SchoolsLibrary(schools: schoolsList.schools)
                self?.fetchSports()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Navigation
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentVods?.programs.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? VODCell, let vod = currentVods?.programs[indexPath.row], let sportsLib = sportsLib, let schoolsLib = schoolsLib else { return UICollectionViewCell() }
        cell.configureView(with: vod, sportsLib: sportsLib, schoolsLib: schoolsLib)
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    private func fetchSports() {
        api.getSports { [weak self] result in
            switch result {
            case .success(let sportsList):
                self?.sportsLib = SportsLibrary(sports: sportsList.sports)
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
                self?.currentVods = response
                
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
