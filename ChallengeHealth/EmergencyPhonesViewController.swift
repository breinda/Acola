import UIKit

class EmergencyPhonesViewController: UIViewController {

   // @IBOutlet weak var boddi: BoddiView!
    
    override func viewDidLoad() {
      //  boddi.addNormalCycleAnimation()
    }
    
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }

}
