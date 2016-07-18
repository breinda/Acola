import UIKit

class ObjetivoAtualViewController: UIViewController {

    var objetivoFinal: String = "objetivo final"
    @IBOutlet weak var objetivoFinalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objetivoFinalLabel.text! = objetivoFinal
    }
    
    @IBAction func voltarWasTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}