import UIKit

private let labelCornerRadius: CGFloat = 4
private let cardCornerRadius: CGFloat = 8

class VODCell: UICollectionViewCell {
    
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var durationLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var schoolsLabel: UILabel!
    @IBOutlet weak private var sportsLabel: UILabel!
    
    func configureView() {
        contentView.backgroundColor = .cyan
        contentView.layer.cornerRadius = cardCornerRadius
        styleTimeLabel()
    }

    private func styleTimeLabel() {
        durationLabel.text = " 0:\(Int.random(in: 10...59)) "
        durationLabel.layer.masksToBounds = true
        durationLabel.layer.cornerRadius = labelCornerRadius
    }
    
    private func styleSchoolsLabel() {
        
    }
    
    private func styleSportsLabel() {
        
    }
}
