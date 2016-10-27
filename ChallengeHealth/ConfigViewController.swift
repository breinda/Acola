import UIKit
import Firebase
import FirebaseAuth

class ConfigViewController: UIViewController {

  //  @IBOutlet weak var boddi: BoddiView!
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
        
      //  boddi.addNormalCycleAnimation()
        
        var handle : FIRAuthStateDidChangeListenerHandle
        
        handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;

                DAO.USERS_REF.observe(.childAdded, with: { (snapshotUser) in
                    if snapshotUser.key == uid {
                        
                        let snapDict = snapshotUser.value as? NSDictionary
                        
                        let name = snapDict!["name"] as! String
                        self.boddiLabel.text! = "Como posso te ajudar, \(name)?"
                    }
                })
            }
        })!
        
        FIRAuth.auth()?.removeStateDidChangeListener(handle)
    }
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonWasTapped(_ sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
}
