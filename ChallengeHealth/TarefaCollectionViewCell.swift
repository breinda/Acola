//
//  TarefaCollectionViewCell.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 18/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

class TarefaCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var nomeTarefaLabel: UILabel!
    
    func configureCell(tarefa: Tarefa){
        self.nomeTarefaLabel.text = tarefa.nome
    }
}