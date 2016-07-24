import UIKit
import Firebase
import FirebaseAuth

class ConfigViewController: UIViewController {

    @IBOutlet weak var boddiLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            for profile in user.providerData {
<<<<<<< cc2efa1e1cf17eaf3020052081851a67504a43a0
                let email = profile.email
                //nameLabel.text! = name!
=======
                //let email = profile.email
                //let name = profile.displayName
                //boddiLabel.text! = "Como posso lhe ajudar, \(name!)?"
>>>>>>> Fixes ConfigVC buttons constraints
                //emailLabel.text! = email!
            }
        }
    }
    
    @IBAction func backButtonWasTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutButtonWasTapped(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}