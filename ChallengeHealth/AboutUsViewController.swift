import UIKit

class AboutUsViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
    }
    
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
