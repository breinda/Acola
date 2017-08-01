import UIKit
import Firebase
import FirebaseAuth
import ElasticTransition

class ConfigViewController: /*UIViewController,*/ ElasticModalViewController, UITextViewDelegate {
    
    @IBOutlet weak var boddiLabel: UITextView!
    
    @IBOutlet weak var backRectangleImageView: UIImageView!
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var boddiImageView: UIImageView!
    @IBOutlet weak var navBarRectangleImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //  boddi.addNormalCycleAnimation()
        
        backRectangleImageView.layer.cornerRadius = 39
        backRectangleImageView.layer.borderWidth = 1
        backRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        
        navBarRectangleImageView.layer.borderWidth = 1
        navBarRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        
        bubbleImageView.layer.cornerRadius = 26
        bubbleImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        bubbleImageView.layer.shadowOpacity = 0.1
        bubbleImageView.layer.shadowRadius = 4
        bubbleImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bubbleImageView.layer.shouldRasterize = true
        
        boddiImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        boddiImageView.layer.shadowOpacity = 0.1
        boddiImageView.layer.shadowRadius = 4
        boddiImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        boddiImageView.layer.shouldRasterize = true
        
        boddiLabel.delegate = self
        
        
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
    
    // force the text in a UITextView to always center itself.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }
    
    // MARK: Navigation
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        
//        var transition = ElasticTransition()
//        transition.edge = .left
//        transition.radiusFactor = 0.3

        self.modalTransition.edge = .right
        
        self.dismiss(animated: true, completion: nil)
    }
    
//    @IBAction func logoutButtonWasTapped(_ sender: AnyObject) {
//        //GoalsVCShouldReload = true
//        try! Auth.auth().signOut()
//        self.dismiss(animated: true, completion: nil)
//    }
    
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
