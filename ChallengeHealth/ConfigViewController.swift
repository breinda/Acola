import UIKit
import Firebase
import FirebaseAuth
import ElasticTransition

class ConfigViewController: /*UIViewController,*/ ElasticModalViewController {
    
    @IBOutlet weak var boddiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  boddi.addNormalCycleAnimation()
        
        var handle : AuthStateDidChangeListenerHandle
        
        handle = (Auth.auth().addStateDidChangeListener { auth, user in
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
        })
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    
    // MARK: Navigation
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        
//        var transition = ElasticTransition()
//        transition.edge = .left
//        transition.radiusFactor = 0.3

        self.modalTransition.edge = .right
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonWasTapped(_ sender: AnyObject) {
        try! Auth.auth().signOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToAboutUs" {
            
            let svc = segue.destination as! AboutUsViewController
            // customization:
            svc.modalTransition.edge = .right
            svc.modalTransition.radiusFactor = 0.3
        }
        
        if segue.identifier == "goToEmergencyPhones" {
            
            let svc = segue.destination as! EmergencyPhonesViewController
            // customization:
            svc.modalTransition.edge = .right
            svc.modalTransition.radiusFactor = 0.3
        }
    }
    
}
