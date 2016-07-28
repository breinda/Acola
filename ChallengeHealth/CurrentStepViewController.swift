import UIKit
import Firebase
import FirebaseAuth

class CurrentStepViewController: UIViewController {

    var goal: String = ""
    var step: String = ""

    var stepIndex: String = "1"
    var goalKey: String = "goalKey"

    var steps = [Step]()

    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepIndexLabel: UILabel!
    @IBOutlet weak var stepDescriptionLabel: UILabel!
    
    @IBOutlet weak var boddiTextBubbleLabel: UILabel!
    
    var isSecondVC = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        boddiTextBubbleLabel.text! = ""
        goalLabel.text! = goal
        stepLabel.text! = step
        stepIndexLabel.text! = stepIndex

        // bota todos os steps referentes ao goal atual num array de steps, pra gente nao ficar perdendo tempo procurando esse treco no banco toda hora
        var handle : FIRAuthStateDidChangeListenerHandle

        handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;

                DAO.USERS_REF.observeEventType(.ChildAdded, withBlock: { (snapshotUser) in
                    if snapshotUser.key == uid {

                        self.stepIndexLabel.text! = snapshotUser.value!["currentStepNumber"] as! String
                        self.stepIndex = snapshotUser.value!["currentStepNumber"] as! String
                        self.goalKey = snapshotUser.value!["currentGoalKey"] as! String
                        let name = snapshotUser.value!["name"] as! String
                        
//                        let motivationString: NSAttributedString = "Você vai se sentir cada vez melhor!!"
//                        motivationString.font = UIFont(name: "", size: "")
                        
                        self.boddiTextBubbleLabel.text! = "\(name)! Tenho certeza de que você é capaz de dar mais este passo em direção ao seu objetivo. Você vai se sentir cada vez melhor!!"

                        if let safeGoalKey = snapshotUser.value!["currentGoalKey"] {
                            // pega o nome do goal atual e bota na label
                            DAO.STD_GOALS_REF.child(String(safeGoalKey)).observeEventType(.ChildAdded, withBlock: { (snapshotGoal) in

                                if snapshotGoal.key == "name" {
                                    self.goal = String(snapshotGoal.value!)
                                    self.goalLabel.text! = String(snapshotGoal.value!)

                                    DAO.STD_STEPS_REF.child(String(safeGoalKey)).observeEventType(.ChildAdded, withBlock: { (snapshotSteps) in

                                        self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))

                                        //print(self.steps.last!.name)

                                        if snapshotSteps.key == self.stepIndex {
                                            self.stepLabel.text! = snapshotSteps.value!["name"] as! String
                                            self.step = snapshotSteps.value!["name"] as! String
                                            self.stepDescriptionLabel.text! = snapshotSteps.value!["description"] as! String
                                        }
                                    })
                                }
                            })
                        }
                    }
                })
            }
        })!

        FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(CurrentStepViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
    }

    override func viewDidAppear(animated: Bool) {
        
        steps.removeAll()
        
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("loginVC")
            self.presentViewController(vc, animated: false, completion: nil)
        }

        goalLabel.text! = goal
        stepLabel.text! = step
        stepIndexLabel.text! = "PASSO \(stepIndex)"

        var handle : FIRAuthStateDidChangeListenerHandle

        handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;

                DAO.USERS_REF.observeEventType(.ChildAdded, withBlock: { (snapshotUser) in
                    if snapshotUser.key == uid {
                        let userDict = snapshotUser.value as! NSDictionary
                        print(userDict)
                        print(snapshotUser.key)

                        let currentStepNumberAux = snapshotUser.value!["currentStepNumber"] as! String
                        self.stepIndexLabel.text! = "PASSO \(currentStepNumberAux)"
                        self.stepIndex = snapshotUser.value!["currentStepNumber"] as! String
                        self.goalKey = snapshotUser.value!["currentGoalKey"] as! String

                        // pega o nome do goal atual e bota na label
                        DAO.STD_GOALS_REF.child(self.goalKey).observeEventType(.ChildAdded, withBlock: { (snapshotGoal) in

                            if snapshotGoal.key == "name" {
                                self.goal = String(snapshotGoal.value!)
                                self.goalLabel.text! = String(snapshotGoal.value!)

                                DAO.STD_STEPS_REF.child(self.goalKey).observeEventType(.ChildAdded, withBlock: { (snapshotSteps) in

                                    self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))

                                    if snapshotSteps.key == self.stepIndex {
                                        self.stepLabel.text! = snapshotSteps.value!["name"] as! String
                                        self.stepDescriptionLabel.text! = snapshotSteps.value!["description"] as! String
                                    }
                                })
                            }
                        })
                    }
                })
            }
            })!

        FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("IOIOIOI")
        if segue.identifier == "goToGoals" {
            print("ENTREY")
            if let destination = segue.destinationViewController as? GoalsViewController {
                // seta o step atual do usuário como 0 -- saber se view inicial é a de goals ou a de currentStep
                
                //self.presentingViewController?.presentViewController(destination, animated: false, completion: nil)
                
                
                var handle : FIRAuthStateDidChangeListenerHandle
                
                handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if let user = user {
                        // User is signed in.
                        let uid = user.uid;
                        
                        DAO.USERS_REF.child(uid).observeEventType(.ChildAdded, withBlock: { (snapshot) in
                            
                            if snapshot.key == "currentStepNumber" {
                                let childUpdates = [snapshot.key: "0"]
                                DAO.USERS_REF.child(uid).updateChildValues(childUpdates)
                            }
                            
                            if snapshot.key == "currentGoalKey" {
                                let childUpdates = [snapshot.key: ""]
                                DAO.USERS_REF.child(uid).updateChildValues(childUpdates)
                            }
                        })
                    }
                    })!
                
                FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
                
                //self.dismissViewControllerAnimated(false, completion: nil)
                
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                let rootVC = appDelegate.window!.rootViewController
                
                // se currentStepVC é o rootVC OU se o rootVC for o loginVC
                if (rootVC!.dynamicType == self.dynamicType || (String(rootVC!.dynamicType) == "LoginViewController" && self.isSecondVC == true)) {
                    print("MA OE CURRENTVC")
                    //self.isSecondVC = false

                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewControllerWithIdentifier("goalsVC")
                    self.presentViewController(vc, animated: true, completion: nil)
                }
                else {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
    }

    @IBAction func doneWasTapped(sender: AnyObject) {
    
        let alertView = UIAlertController(title: "UAU!",
                                          message: "você se sente totalmente confortável com o passo atual?" as String, preferredStyle:.ActionSheet)
        let okAction = UIAlertAction(title: "sim, bora próximo passo", style: .Default) { UIAlertAction in
            var handle : FIRAuthStateDidChangeListenerHandle
            
            handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                if let user = user {
                    // User is signed in.
                    let uid = user.uid;
                    
                    DAO.USERS_REF.child(uid).observeEventType(.ChildAdded, withBlock: { (snapshot) in
                        
                        if snapshot.key == "currentStepNumber" {
                            
                            let updateStepString = snapshot.value as! String
                            var updateStepInt = Int(updateStepString)
                            
                            // se estivermos no ultimo passo, segue de volta pra tela de goals
                            if (self.steps[updateStepInt! - 1].isLastStep == true) {
                                self.performSegueWithIdentifier("goToGoals", sender: self)
                            }
                            else {
                                updateStepInt = updateStepInt! + 1
                                
                                self.stepIndex = String(updateStepInt!)
                                self.step = self.steps[Int(self.stepIndex)! - 1].name
                                
                                let childUpdates = [snapshot.key: String(updateStepInt!)]
                                DAO.USERS_REF.child(uid).updateChildValues(childUpdates)
                                
                                self.viewDidAppear(false)
                            }
                        }
                        
                    })
                }
                })!
            
            FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
        }
        
        let cancelAction = UIAlertAction(title: "pensando bem, não", style: .Cancel, handler: nil)
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        self.presentViewController(alertView, animated: true, completion: nil)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Right:
                print("Swiped right")
                performSegueWithIdentifier("goToGoals", sender: self)
            case UISwipeGestureRecognizerDirection.Down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.Left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.Up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}