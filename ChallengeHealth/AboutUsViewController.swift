import UIKit

class AboutUsViewController: ElasticModalViewController/*UIViewController*/, UIScrollViewDelegate {

    @IBOutlet weak var aboutTextView: UITextView!
    
    override func viewDidLoad() {
        
    }
    
    // faz com que a textView apareça scrollada a partir do início
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aboutTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        self.modalTransition.edge = .right
        self.dismiss(animated: true, completion: nil)
    }
    
}
