import UIKit
import Firebase
import FirebaseAuth

class UserSettingsViewController: UIViewController {

    override func viewDidLoad() {
        
    }

    @IBAction func returnButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension UserSettingsViewController: UITableView {

    @IBOutlet weak var userSettingsTableView: UITableView!

}