//
//  ConfigChildViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 01/08/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit
import Firebase

class ConfigChildViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logoutButtonWasTapped(_ sender: AnyObject) {
        //GoalsVCShouldReload = true
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
}
