//
//  StepCollectionViewCell.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 26/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit

class StepCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackRectangleImageView: UIImageView!
    @IBOutlet weak var cantoMontanhaImageView: UIImageView!
    
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var stepNameLabel: UITextView!
    
    func configureCell(_ step: Step) {
        self.stepNameLabel.text = step.name
        self.stepNumberLabel.text = step.index
        
        if step.isLastStep {
            cantoMontanhaImageView.image = UIImage(named: "cantoMontanhaStepsTop_1x")
        }
        else {
            cantoMontanhaImageView.image = UIImage(named: "cantoMontanhaSteps_1x")
        }
    }
}
