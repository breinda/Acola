import UIKit

class AboutUsViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        
    }
    
    // faz com que a textView apareça scrollada a partir do início
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aboutTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
