import UIKit

private let labelCornerRadius: CGFloat = 4
private let cardCornerRadius: CGFloat = 8

class VODCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var durationLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var schoolsLabel: UILabel!
    @IBOutlet weak private var sportsLabel: UILabel!
    
    func configureView(with vod: Vod, sportsLib: SportsLibrary, schoolsLib: SchoolsLibrary) {
        
        contentView.layer.cornerRadius = cardCornerRadius
        styleTimeLabel()
        loadImage(url: vod.images.small)
        titleLabel.text = vod.title
        if let schools = vod.schools {
            configureSchoolsLabel(schools: schools, schoolsLib: schoolsLib)
        }
        
        if let sports = vod.sports {
            configureSportsLabel(sports: sports, sportsLib: sportsLib)
        }
        configureDurationLabel(length: vod.duration)
    }
    
    private func configureDurationLabel(length: Double) {
        let duration: TimeInterval = length / 60 // conversion to seconds
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [ .minute, .second ]
        formatter.zeroFormattingBehavior = [ .pad ]
        
        let formattedDuration = formatter.string(from: duration)
        durationLabel.text = formattedDuration
    }
    
    private func configureSportsLabel(sports: [VodSport], sportsLib: SportsLibrary) {
        let names = sports.map { vodSport in
            return vodSport.getName(lib: sportsLib)
        }
        sportsLabel.text = names.joined(separator: ", ")
    }
    
    private func configureSchoolsLabel(schools: [VodSchool], schoolsLib: SchoolsLibrary) {
        let names = schools.map { vodSchool in
            return vodSchool.getName(lib: schoolsLib)
        }
        schoolsLabel.text = names.joined(separator: ", ")
    }
    
    private func styleTimeLabel() {
        durationLabel.layer.masksToBounds = true
        durationLabel.layer.cornerRadius = labelCornerRadius
    }

    private func loadImage(url: URL) {
        
        if let cachedImage = imageCache.object(forKey: URLKey(url: url)) {
            self.imageView.image = cachedImage
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data { // should have some default image as a graceful fallback
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: URLKey(url: url))
                        self.imageView.image = image
                    }
                }
            }
        }.resume()
    }
}

