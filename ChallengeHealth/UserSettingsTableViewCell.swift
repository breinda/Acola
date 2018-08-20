import UIKit

let detailViewDefaultHeight: CGFloat = 87
let lowLayoutPriority: Float = 250
let highLayoutPriority: Float = 999

class UserSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var detailViewHeightConstraint: NSLayoutConstraint!

    var showsDetails = false {
        didSet {
            detailViewHeightConstraint.priority = UILayoutPriority(rawValue: showsDetails ? lowLayoutPriority : highLayoutPriority)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailViewHeightConstraint.constant = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
