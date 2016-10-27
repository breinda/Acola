import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mountainImage: UIImageView!
    
    @IBOutlet weak var goalNameLabel: UILabel!
    
    
    
    
    func configureCell(_ goal: Goal) {
        self.goalNameLabel.text = goal.name
    }
    
//    /**
//     Allows you to generate a cell without dequeueing one from a table view.
//     - Returns: The cell loaded from its nib file.
//     */
//    class func fromNib() -> GoalCollectionViewCell?
//    {
//        var cell: GoalCollectionViewCell?
//        let nibViews = NSBundle.mainBundle().loadNibNamed("GoalCollectionViewCell", owner: nil, options: nil)
//        for nibView in nibViews {
//            if let cellView = nibView as? GoalCollectionViewCell {
//                cell = cellView
//            }
//        }
//        return cell
//    }
    
}
