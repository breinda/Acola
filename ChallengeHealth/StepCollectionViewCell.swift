//
//  StepCollectionViewCell.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 26/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit

var stepUserInteraction: Bool = false

class StepCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackRectangleImageView: UIImageView!
    @IBOutlet weak var cantoMontanhaImageView: UIImageView!
    
    @IBOutlet weak var stepNumberLabel: UILabel!
    
    @IBOutlet weak var stepNameTextField: StepCellTextField!
    
    func configureCell(_ step: Step) {
        self.stepNameTextField.text = step.name
        self.stepNumberLabel.text = step.index
        
        self.stepNameTextField.isUserInteractionEnabled = stepUserInteraction
        
        if step.isLastStep {
            cantoMontanhaImageView.image = UIImage(named: "cantoMontanhaStepsTop_1x")
        }
        else {
            cantoMontanhaImageView.image = UIImage(named: "cantoMontanhaSteps_1x")
        }
        
        //self.stepNameLabel.isUserInteractionEnabled = false
    }
}
