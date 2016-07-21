import UIKit

let detailViewDefaultHeight: CGFloat = 87
let lowLayoutPriority: Float = 250
let highLayoutPriority: Float = 999

class UserSettingsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var detailViewHeightConstraint: NSLayoutConstraint!

    var showsDetails = false {
        didSet {
            detailViewHeightConstraint.priority = showsDetails ? lowLayoutPriority : highLayoutPriority
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailViewHeightConstraint.constant = 0
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
