import UIKit

class EmergencyPhonesViewController: UIViewController {

    @IBOutlet weak var boddiView: BoddiView!
    
    @IBAction func returnButtonWasTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        boddiView.addNormalCycleAnimation()
    }

}
