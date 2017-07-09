//
//  SummitReachedViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 16/09/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit

class SummitReachedViewController: UIViewController {

    @IBOutlet weak var descTextView: UITextView!
    
   // @IBOutlet weak var mountainView: BoddiMountainView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // mountainView.addClimbingBigMountainAnimation()
    }
    
    // faz com que a textView apareça scrollada a partir do início
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descTextView.setContentOffset(CGPoint.zero, animated: false)
    }

    @IBAction func OKButtonWasPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
}
