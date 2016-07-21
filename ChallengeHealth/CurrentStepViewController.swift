import UIKit
import FirebaseAuth

class CurrentStepViewController: UIViewController {

    var goal: String = "objetivo final"
    var step: String = "passo atual"
    var stepIndex: String = "1"
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepIndexLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalLabel.text! = goal
        stepLabel.text! = step
        stepIndexLabel.text! = stepIndex
    }
    
    override func viewDidAppear(animated: Bool) {
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
            self.presentViewController(vc, animated: false, completion: nil)
        }
    }
    
    @IBAction func backButtonWasTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}