//
//  GoalCollectionViewCell.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 18/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

class GoalCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var goalNameLabel: UILabel!
    
    func configureCell(goal: Goal){
        self.goalNameLabel.text = goal.name
    }
    
}