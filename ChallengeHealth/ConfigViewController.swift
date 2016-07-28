import UIKit
import Firebase
import FirebaseAuth

class ConfigViewController: UIViewController {

    @IBOutlet weak var boddiLabel: UILabel!
    @IBOutlet weak var boddiView: BoddiView!
    
    override func viewDidAppear(animated: Bool) {
        boddiView.addAppearNormalAnimation(removedOnCompletion: true, completion: {(finished) -> Void in
            
            if finished {
                self.boddiView.addNormalCycleAnimation()
            }
            
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser {
            for profile in user.providerData {
                //let email = profile.email
                //let name = profile.displayName
                //boddiLabel.text! = "Como posso lhe ajudar, \(name!)?"
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