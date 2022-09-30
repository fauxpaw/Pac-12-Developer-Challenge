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
        titleLabel.text = vod.title
        if let schoolNames = vod.schools?.compactMap({ vodSchool in
            return vodSchool.getName(lib: schoolsLib)
        }) {
            schoolsLabel.text = schoolNames.joined(separator: ", ")
        }
        
        if let sportsNames = vod.sports?.compactMap({ vodSport in
            return vodSport.getName(lib: sportsLib)
        }) {
            sportsLabel.text = sportsNames.joined(separator: ", ")
        }
        imageView.loadFrom(url: vod.images.small)
        contentView.layer.cornerRadius = cardCornerRadius
        styleTimeLabel()
    }

    private func styleTimeLabel() {
        durationLabel.text = " 0:\(Int.random(in: 10...59)) "
        durationLabel.layer.masksToBounds = true
        durationLabel.layer.cornerRadius = labelCornerRadius
    }
    
    private func styleSchoolsLabel(lib: SchoolsLibrary) {
        
    }
    
    private func styleSportsLabel(lib: SportsLibrary) {
        
    }
}

extension UIImageView {
        
    func loadFrom(url: URL) {
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}
