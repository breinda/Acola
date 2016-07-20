//
//  TarefaCollectionViewCell.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 18/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

class TasksCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var taskNameLabel: UILabel!
    
    func configureCell(task: Task){
        self.taskNameLabel.text = task.name
    }
    
}