import UIKit
import Firebase

class CurrentStepViewController: UIViewController {

    var goal: String = "objetivo final"
    var step: String = "passo atual"
    var stepIndex: String = "1"
    
    // vars pra que eu possa achar o step atual no DB
    var goalKey: String = "goalKey"
    var stepKey: String = "one"
    
    var steps = [Step]()
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepIndexLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goalLabel.text! = goal
        stepLabel.text! = step
        stepIndexLabel.text! = stepIndex
        
        print(goalKey)
        
        // pega os steps do banco referentes ao goal atual e os armazena no array de steps
        DAO.STD_STEPS_REF.child(goalKey).observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            self.steps.append(Step(index: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>))
            
            print("steps.last.name")
            print(self.steps.last?.name)
            print("dteps.last.description")
            print(self.steps.last?.description)
            print("steps.last.key")
            print(self.steps.last?.index)
        })
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
    
    @IBAction func doneWasTapped(sender: AnyObject) {
        
    }
}