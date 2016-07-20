import UIKit
import Firebase
import FirebaseAuth

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var userSettingsTableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        userSettingsTableView.delegate = self
        userSettingsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func returnButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}