//
//  ConfigViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 18/07/16.
//  Copyright © 2016 Brenda Carrocino. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConfigViewController: UIViewController {

    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            for profile in user.providerData {
//                let providerID = profile.providerID
//                let uid = profile.uid;  // Provider-specific UID
//                let name = profile.displayName
                let email = profile.email
//                let photoURL = profile.photoURL
//                
                //nomeLabel.text! = name!
                emailLabel.text! = email!
            }
        }
    }
    @IBAction func voltarWasTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutWasTapped(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
