import UIKit
import Firebase
import FirebaseAuth

class CurrentStepViewController: UIViewController {
    
    var goal: String = ""
    var step: String = ""
    
    var stepIndex: String = "1"
    var goalKey: String = "goalKey"
    var name: String = ""
    
    var steps = [Step]()
    
    var summitWasReached: Bool = false
    
    @IBOutlet weak var goalLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var stepIndexLabel: UILabel!
    //@IBOutlet weak var stepDescriptionLabel: UILabel!
    
    @IBOutlet weak var boddiTextBubbleLabel: UILabel!
    
    var isSecondVC = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        goalLabel.text = goal
//        stepLabel.text = step
        
        self.modalTransitionStyle = .crossDissolve
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(CurrentStepViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        steps.removeAll()
        
        if summitWasReached {
            performSegue(withIdentifier: "goToGoals", sender: self)
        }
        
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(vc, animated: false, completion: nil)
        }
        
        handleAsynchronousRequest { numberCompleted in
            if numberCompleted == 3 {
                print("AEAEAEEA")
                print("number completed = \(numberCompleted)")
                
                self.goalLabel.text! = self.goal
                
                self.step = self.steps[Int(self.stepIndex)! - 1].name
                
                self.stepLabel.text! = self.step
                self.stepLabel.alpha = 1
                self.stepIndexLabel.text! = "PASSO \(self.stepIndex)"
                
                self.boddiTextBubbleLabel.text! = "\(self.name)! Tenho certeza de que você é capaz de dar mais este passo em direção ao seu objetivo. Você vai se sentir cada vez melhor!!"
                
                DAO.STD_STEPS_REF.child(self.goalKey).removeAllObservers()
                DAO.STD_GOALS_REF.child(self.goalKey).removeAllObservers()
                DAO.USERS_REF.removeAllObservers()
            }
                
            else {
                print("OOPSIE ainda nao")
                print("number completed = \(numberCompleted)")
            }
        }
    }
    
    
    // MARK: Handlers for Asynchronous Stuff
    
    func handleAsynchronousRequest (completionHandlerStepNumber: @escaping (Int) -> Void) {

        var numCompleted = 0
        
        // vamos botar todos os steps referentes ao goal atual num array de steps, pra gente nao ficar perdendo tempo procurando esse treco no banco toda hora
        let uid = userID
        
        DAO.USERS_REF.observe(.childAdded, with: { (snapshotUser) in
            if snapshotUser.key == uid {
                
                // atualiza o passo atual no qual se encontra o usuário
                let snapshotUserDict = snapshotUser.value as? NSDictionary
                print(snapshotUserDict!)
                print(snapshotUser.key)
                
                self.stepIndex = snapshotUserDict!["currentStepNumber"] as! String
                self.goalKey = snapshotUserDict!["currentGoalKey"] as! String
                
                self.name = snapshotUserDict!["name"] as! String
                numCompleted += 1
                completionHandlerStepNumber(numCompleted)
                
                // pega o nome do goal atual e bota na label
                DAO.STD_GOALS_REF.child(self.goalKey).observe(.childAdded, with: { (snapshotGoal) in
                    
                    if snapshotGoal.key == "name" {
                        self.goal = String(describing: snapshotGoal.value!)
                        //self.goalLabel.text! = String(describing: snapshotGoal.value!)
                        
                        numCompleted += 1
                        completionHandlerStepNumber(numCompleted)
                        
                        DAO.STD_STEPS_REF.child(self.goalKey).observe(.childAdded, with: { (snapshotSteps) in
                            
                            self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))
                            
                            if snapshotSteps.key == self.stepIndex {
                                //self.stepLabel.text! = snapshotUserDict!["name"] as! String
                                
                                numCompleted += 1
                                completionHandlerStepNumber(numCompleted)
                                //self.stepDescriptionLabel.text! = snapshotSteps.value!["description"] as! String
                            }
                        })
                    }
                })
            }
        })
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToConfigFromStep" {
            
            let svc = segue.destination as! ConfigViewController
            // customization:
            svc.modalTransition.edge = .right
            svc.modalTransition.radiusFactor = 0.3
        }
        
        if segue.identifier == "goToGoals" {
            print("ENTREY")
            if segue.destination is GoalsViewController {
                
                summitWasReached = false
                stepLabel.alpha = 0
                
                // seta o step atual do usuário como 0 -- saber se view inicial é a de goals ou a de currentStep
                
                var handle : AuthStateDidChangeListenerHandle
                
                handle = (Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user {
                        // User is signed in.
                        let uid = user.uid;
                        
                        DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                            
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
                })
                
                Auth.auth().removeStateDidChangeListener(handle)
                
                //self.dismissViewControllerAnimated(false, completion: nil)
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let rootVC = appDelegate.window!.rootViewController
                
                // se currentStepVC é o rootVC OU se o rootVC for o loginVC
                if (type(of: rootVC!) == type(of: self) || (String(describing: type(of: rootVC!)) == "LoginViewController" && self.isSecondVC == true)) {
                    print("MA OE CURRENTVC")
                    //self.isSecondVC = false
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "goalsVC")
                    self.present(vc, animated: true, completion: nil)
                }
                else {
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    
    @IBAction func doneWasTapped(_ sender: AnyObject) {
        
        let alertView = UIAlertController(title: "UAU!",
                                          message: "você se sente totalmente confortável com o passo atual?" as String, preferredStyle:.actionSheet)
        let okAction = UIAlertAction(title: "sim, bora próximo passo", style: .default) { UIAlertAction in
            var handle : AuthStateDidChangeListenerHandle
            
            handle = (Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    // User is signed in.
                    let uid = user.uid;
                    
                    DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                        
                        if snapshot.key == "currentStepNumber" {
                            
                            let updateStepString = snapshot.value as! String
                            var updateStepInt = Int(updateStepString)
                            
                            // se estivermos no último passo, segue para o topo da montanha
                            if (self.steps[updateStepInt! - 1].isLastStep == true) {
                                
                                self.stepLabel.alpha = 0
                                
                                self.performSegue(withIdentifier: "goToSummit", sender: self)
                                
                                self.summitWasReached = true
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
            })
            
            Auth.auth().removeStateDidChangeListener(handle)
        }
        
        let cancelAction = UIAlertAction(title: "pensando bem, não", style: .cancel, handler: nil)
        alertView.addAction(okAction)
        alertView.addAction(cancelAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
                GoalsVCShouldReload = true
                performSegue(withIdentifier: "goToGoals", sender: self)
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
}
