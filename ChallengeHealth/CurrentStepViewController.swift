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
    //@IBOutlet weak var stepDescriptionLabel: UILabel!
   // @IBOutlet weak var boddi: BoddiView!
    @IBOutlet weak var boddiTextBubbleLabel: UILabel!
    
    @IBOutlet weak var boddiTextBubbleLabel: UILabel!
    
    var isSecondVC = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Animations:
      //  boddi.addMountainNormalCycleAnimation()
        
        boddiTextBubbleLabel.text! = ""
        goalLabel.text! = goal
        stepLabel.text! = step
        stepIndexLabel.text! = stepIndex

        // bota todos os steps referentes ao goal atual num array de steps, pra gente nao ficar perdendo tempo procurando esse treco no banco toda hora
        var handle : FIRAuthStateDidChangeListenerHandle

        handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;
                
                //var latestSnapshotUser = null

                DAO.USERS_REF.observe(.childAdded, with: { (snapshotUser) in
                    if snapshotUser.key == uid {
                        
                        print("ENTREI")
                        print(snapshotUser)
                        print(snapshotUser.key)
                        print(snapshotUser.value)

                        let snapshotUserDict = snapshotUser.value as? NSDictionary
                        
                        self.stepIndexLabel.text! = snapshotUserDict!["currentStepNumber"] as! String
                        self.stepIndex = snapshotUserDict!["currentStepNumber"] as! String
                        self.goalKey = snapshotUserDict!["currentGoalKey"] as! String
                        let name = snapshotUserDict!["name"] as! String
                        
                        
                        
//                        while (self.goalKey == "") {
//                            let snapshotUserDict = snapshotUser.value as? NSDictionary
//                            
//                            self.stepIndexLabel.text! = snapshotUserDict!["currentStepNumber"] as! String
//                            self.stepIndex = snapshotUserDict!["currentStepNumber"] as! String
//                            self.goalKey = snapshotUserDict!["currentGoalKey"] as! String
//                            
//                            print("LALA")
//                        }
                        
//                        let motivationString: NSAttributedString = "Você vai se sentir cada vez melhor!!"
//                        motivationString.font = UIFont(name: "", size: "")
                        
                        self.boddiTextBubbleLabel.text! = "\(name)! Tenho certeza de que você é capaz de dar mais este passo em direção ao seu objetivo. Você vai se sentir cada vez melhor!!"

                        if let safeGoalKey = snapshotUserDict!["currentGoalKey"] {
                            
                            print("safeGoalKey")
                            print("i am 33\(safeGoalKey)44")
                            //print(safeGoalKey.key)
                           // print(safeGoalKey.value)
                            
                            
                            let safeGoalKeyStr = snapshotUserDict!["currentGoalKey"]
                            print("safeGoalKeyStr")
                            print(safeGoalKeyStr)
                            // pega o nome do goal atual e bota na label
                            DAO.STD_GOALS_REF.child(safeGoalKeyStr as! String).observe(.childAdded, with: { (snapshotGoal) in
                                
                                print("OIOIOI")
                                
                                print(snapshotGoal)
                                
                                print(snapshotGoal.key)
                                print(snapshotGoal.value)
                                
                                let snapshotGoalDict = snapshotGoal.value //as? NSDictionary
                                
                                print("OLHA AQUI GAROTA")
                                
                                print(snapshotGoalDict)

                                if snapshotGoal.key == "name" {
                                    self.goal = String(describing: snapshotGoalDict!)
                                    self.goalLabel.text! = String(describing: snapshotGoalDict!)

                                    DAO.STD_STEPS_REF.child(String(describing: safeGoalKey)).observe(.childAdded, with: { (snapshotSteps) in

                                        self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))

                                        //print(self.steps.last!.name)

                                        if snapshotSteps.key == self.stepIndex {
                                            
                                            print("OIOIOI2")
                                            
                                            print(snapshotSteps)
                                            
                                            print(snapshotSteps.key)
                                            print(snapshotSteps.value)
                                            
                                            let snapshotStepsDict = snapshotSteps.value as? NSDictionary
                                            
                                            
                                            print("OLHA AQUI GAROTA2")
                                            
                                            print(snapshotStepsDict)
                                            
                                            self.stepLabel.text! = snapshotStepsDict!["name"] as! String
                                            self.step = snapshotStepsDict!["name"] as! String
                                            //self.stepDescriptionLabel.text! = snapshotSteps.value!["description"] as! String
                                        }
                                    })
                                }
                            })
                        }
                    }
                })
            }
        })!

        FIRAuth.auth()?.removeStateDidChangeListener(handle)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(CurrentStepViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        steps.removeAll()
        
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(vc, animated: false, completion: nil)
        }
        
        // VAI PRA TELA DE OBJETIVOS CASO TENHAMOS ACABADO DE CONCLUIR UM OBJETIVO
        
        var handle : FIRAuthStateDidChangeListenerHandle
        
        handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;
                
                DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                    
                    if snapshot.key == "currentStepNumber" {
                        let snapshotValue = snapshot.value as! String
                        
                        
                        print("snapshotValue eh")
                        print(snapshotValue)
                        
                        if snapshotValue == "0" {
                            self.performSegue(withIdentifier: "goToGoals", sender: self)
                            
                        }
                    }
                })
            }
            })!
        
        FIRAuth.auth()?.removeStateDidChangeListener(handle)
        
        

        goalLabel.text! = goal
        stepLabel.text! = step
        stepIndexLabel.text! = "PASSO \(stepIndex)"

        //var handle : FIRAuthStateDidChangeListenerHandle

        handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;

                DAO.USERS_REF.observe(.childAdded, with: { (snapshotUser) in
                    if snapshotUser.key == uid {
                        let snapshotUserDict = snapshotUser.value as? NSDictionary
                        print(snapshotUserDict)
                        print(snapshotUser.key)

                        let currentStepNumberAux = snapshotUserDict!["currentStepNumber"] as! String
                        self.stepIndexLabel.text! = "PASSO \(currentStepNumberAux)"
                        self.stepIndex = snapshotUserDict!["currentStepNumber"] as! String
                        self.goalKey = snapshotUserDict!["currentGoalKey"] as! String

                        // pega o nome do goal atual e bota na label
                        DAO.STD_GOALS_REF.child(self.goalKey).observe(.childAdded, with: { (snapshotGoal) in

                            if snapshotGoal.key == "name" {
                                self.goal = String(describing: snapshotGoal.value!)
                                self.goalLabel.text! = String(describing: snapshotGoal.value!)

                                DAO.STD_STEPS_REF.child(self.goalKey).observe(.childAdded, with: { (snapshotSteps) in

                                    self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))

                                    if snapshotSteps.key == self.stepIndex {
                                        let snapshotStepsDict = snapshotSteps.value as? NSDictionary
                                        
                                        self.stepLabel.text! = snapshotStepsDict!["name"] as! String
                                        //self.stepDescriptionLabel.text! = snapshotSteps.value!["description"] as! String
                                    }
                                })
                            }
                        })
                    }
                })
            }
            })!

        FIRAuth.auth()?.removeStateDidChangeListener(handle)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("IOIOIOI")
        if segue.identifier == "goToGoals" {
            print("ENTREY")
            if let destination = segue.destination as? GoalsViewController {
                // seta o step atual do usuário como 0 -- saber se view inicial é a de goals ou a de currentStep
                
                //self.presentingViewController?.presentViewController(destination, animated: false, completion: nil)
                
                
                var handle : FIRAuthStateDidChangeListenerHandle
                
                handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
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
                    })!
                
                FIRAuth.auth()?.removeStateDidChangeListener(handle)
                
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
            var handle : FIRAuthStateDidChangeListenerHandle
            
            handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
                if let user = user {
                    // User is signed in.
                    let uid = user.uid;
                    
                    DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                        
                        if snapshot.key == "currentStepNumber" {
                            
                            let updateStepString = snapshot.value as! String
                            var updateStepInt = Int(updateStepString)
                            
                            // se estivermos no ultimo passo, segue de volta pra tela de goals
                            if (self.steps[updateStepInt! - 1].isLastStep == true) {
                                
                                var handle : FIRAuthStateDidChangeListenerHandle
                                
                                handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
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
                                    })!
                                
                                FIRAuth.auth()?.removeStateDidChangeListener(handle)
                                
                                self.performSegue(withIdentifier: "goToSummit", sender: self)
                            }
                            else {
                                updateStepInt = updateStepInt! + 1
                                
                                self.stepIndex = String(updateStepInt!)
                                self.step = self.steps[Int(self.stepIndex)! - 1].name
                                
                                let childUpdates = [snapshot.key: String(updateStepInt!)]
                                DAO.USERS_REF.child(uid).updateChildValues(childUpdates)
                                
                                //Animation:
                                
//                                self.boddi.addClimbMountainAnimation(removedOnCompletion: true, completion: {(finished) -> Void in
//                                    
//                                    if finished {
//                                        self.boddi.addMountainNormalCycleAnimation()
//                                    }
//                                    
//                                })
                                
                                self.viewDidAppear(false)
                            }
                        }
                        
                    })
                }
                })!
            
            FIRAuth.auth()?.removeStateDidChangeListener(handle)
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
