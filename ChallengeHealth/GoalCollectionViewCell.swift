import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var goalNameLabel: UILabel!
    
    @IBOutlet weak var mountainImage: UIImageView!
    
    
    func configureCell(goal: Goal) {
        self.goalNameLabel.text = goal.name
    }
    
}