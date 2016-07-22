import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var goalNameLabel: UILabel!
    
    func configureCell(goal: Goal) {
        self.goalNameLabel.text = goal.name
    }
    
}