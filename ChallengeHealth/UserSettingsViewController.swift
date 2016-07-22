import UIKit
import Firebase

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var userSettingsTableView: UITableView!
    
    var expandedIndexPath: NSIndexPath? {
        didSet {
            switch expandedIndexPath {
            case .Some(let index):
                userSettingsTableView.reloadRowsAtIndexPaths([index], withRowAnimation: UITableViewRowAnimation.Automatic)
            case .None:
                userSettingsTableView.reloadRowsAtIndexPaths([oldValue!], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        userSettingsTableView.delegate = self
        userSettingsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        
        userSettingsTableView.contentInset.top = 0
        //userSettingsTableView.rowHeight = 97
        userSettingsTableView.rowHeight = UITableViewAutomaticDimension
        userSettingsTableView.estimatedRowHeight = 177
    }
    
    @IBAction func returnButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}