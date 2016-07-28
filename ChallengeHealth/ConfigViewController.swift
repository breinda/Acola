import UIKit
import Firebase
import FirebaseAuth

class ConfigViewController: UIViewController {

    @IBOutlet weak var boddiLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let user = FIRAuth.auth()?.currentUser {
//            for profile in user.providerData {
//                //let email = profile.email
//                //let name = profile.displayName
//                //boddiLabel.text! = "Como posso lhe ajudar, \(name!)?"
//                //emailLabel.text! = email!
//            }
//        }
        
        var handle : FIRAuthStateDidChangeListenerHandle
        
        handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;

                DAO.USERS_REF.observeEventType(.ChildAdded, withBlock: { (snapshotUser) in
                    if snapshotUser.key == uid {
                        
                        let name = snapshotUser.value!["name"] as! String
                        self.boddiLabel.text! = "Como posso te ajudar, \(name)?"
                    }
                })
            }
        })!
        
        FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
    }
    
    @IBAction func backButtonWasTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func logoutButtonWasTapped(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}