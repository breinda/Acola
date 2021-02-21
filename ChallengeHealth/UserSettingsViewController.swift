import UIKit
import Firebase
import FirebaseAuth

class UserSettingsViewController: UIViewController {
    
    @IBOutlet weak var userSettingsTableView: UITableView!
    
    var expandedIndexPath: IndexPath? {
        didSet {
            switch expandedIndexPath {
            case .some(let index):
                userSettingsTableView.reloadRows(at: [index], with: UITableView.RowAnimation.automatic)
            case .none:
                userSettingsTableView.reloadRows(at: [oldValue!], with: UITableView.RowAnimation.automatic)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        userSettingsTableView.delegate = self
        userSettingsTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        
        userSettingsTableView.contentInset.top = 0
        //userSettingsTableView.rowHeight = 97
        userSettingsTableView.rowHeight = UITableView.automaticDimension
        userSettingsTableView.estimatedRowHeight = 177
    }
    
    @IBAction func returnButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }

}
