import UIKit
import FirebaseAuth

class ConfigViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
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
                //nameLabel.text! = name!
                emailLabel.text! = email!
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