import UIKit
import Firebase
import FirebaseAuth

class GoalsViewController: UIViewController {
    
    // @IBOutlet weak var boddi: BoddiView!
    @IBOutlet weak var goalsCollectionView: UICollectionView!
    
    var goals = [Goal]()
    
    var isSecondVC = false
    
    var cellWidth: CGFloat = 0
    let columnNum: CGFloat = 1
    
    @IBOutlet weak var boddiBubble: UIImageView!
    @IBOutlet weak var boddi: UIImageView!
    
    let mountainArray: [UIImage] = [UIImage(named: "iconeMontanha1")!, UIImage(named: "iconeMontanha2")!, UIImage(named: "iconeMontanha4")!, UIImage(named: "iconeMontanha3")!]
    var mountainArrayIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalTransitionStyle = .crossDissolve
        
        //boddi.addAppearHappyJumpAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        goals.removeAll()
        
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if Auth.auth().currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            self.present(vc, animated: false, completion: nil)
        }
        
        goalsCollectionView.backgroundColor = UIColor.clear
        //goalsCollectionView.reloadData()
        
        handleAsynchronousRequestForCstGoalsFromThisUser { numberCompleted, totalUsersWithCstGoals, userWasFound in
            
            if numberCompleted == totalUsersWithCstGoals { // se tivermos chegado ao fim da busca
                
                if userWasFound == true { // usuário possui algum custom goal criado!
                    print("achei o usuário AFINAL")
                    
                    // pegamos, então, todos os std goals + os custom goals do usuário
                    self.handleAsynchronousRequestForEveryStdGoalAndCstGoal { numberCompleted, totalCstGoalsThisUser, totalStdGoals in
                        if numberCompleted == totalCstGoalsThisUser + totalStdGoals {
                            print("userWasFound = TRUE, AEAEAEEA")
                            print("userWasFound = TRUE, number completed = \(numberCompleted)")
                            print("userWasFound = TRUE, totalCstGoals = \(totalCstGoalsThisUser)")
                            print("userWasFound = TRUE, totalStdGoals = \(totalStdGoals)")
                            
                            self.goalsCollectionView.reloadData()
                        }
                            
                        else {
                            print("userWasFound = TRUE, OOPSIE ainda nao")
                            print("userWasFound = TRUE, number completed = \(numberCompleted)")
                            print("userWasFound = TRUE, totalCstGoals = \(totalCstGoalsThisUser)")
                            print("userWasFound = TRUE, totalStdGoals = \(totalStdGoals)")
                        }
                    }
                }
                else { // não achamos o usuário ao final da busca == usuário não possui nenhum custom goal criado
                    
                    // pegamos, então, apenas os std goals
                    self.handleAsynchronousRequestForEveryStdGoal { numberCompleted, totalStdGoals in
                        
                        if numberCompleted == totalStdGoals {
                            print("userWasFound == FALSE, AEAEAEEA")
                            print("userWasFound == FALSE, number completed = \(numberCompleted)")
                            print("userWasFound == FALSE, totalStdGoals = \(totalStdGoals)")
                            
                            self.goalsCollectionView.reloadData()
                        }
                            
                        else {
                            print("userWasFound == FALSE, OOPSIE ainda nao")
                            print("userWasFound == FALSE, number completed = \(numberCompleted)")
                            print("userWasFound == FALSE, totalStdGoals = \(totalStdGoals)")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: Handlers for Asynchronous Stuff
    
    // checa se o usuário corrente possui algum custom goal criado
    func handleAsynchronousRequestForCstGoalsFromThisUser (completionHandlerUsers: @escaping (_ numberCompleted: Int, _ totalUsersWithCstGoals: Int, _ userWasFound: Bool) -> Void) {
        var numberCompleted = 0
        var totalUsersWithCstGoals = -10
        var userWasFound = false
        
        // procura saber se usuário possui custom goals criados
        var handle : AuthStateDidChangeListenerHandle
        
        handle = (Auth.auth().addStateDidChangeListener { auth, user in
            
            if let user = user { // User is signed in.
                let uid = user.uid;
                print("uid: \(uid)")
                
                DAO.CST_GOALS_REF.observe(.childAdded, with: { (snapshot) in
                    
                    if snapshot.key == "numberOfKeys" {
                        print("to no numberOfKeys-USERS WITH CST GOALS")
                        
                        totalUsersWithCstGoals = snapshot.value as! Int
                        print("totalUsersWithCstGoals = \(totalUsersWithCstGoals)")
                        
                        completionHandlerUsers(numberCompleted, totalUsersWithCstGoals, userWasFound)
                    }
                    else {
                        if snapshot.key == uid { // usuário encontrado na lista = usuário possui algum custom goal criado
                            userWasFound = true
                            completionHandlerUsers(numberCompleted, totalUsersWithCstGoals, userWasFound)
                        }
                        
                        numberCompleted += 1
                        completionHandlerUsers(numberCompleted, totalUsersWithCstGoals, userWasFound)
                    }
                })
                
            }
        })
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    // função que pega todos os std goals + os custom goals do usuário
    func handleAsynchronousRequestForEveryStdGoalAndCstGoal (completionHandlerGoals: @escaping (_ numberCompleted: Int, _ totalCstGoalsThisUser: Int, _ totalStdGoals: Int) -> Void) {
        
        var numberCompleted = 0
        var totalCstGoalsThisUser = -10
        var totalStdGoals = -10

        
        // pega os custom goals do banco e os armazena no array goals
        var handle : AuthStateDidChangeListenerHandle

        handle = (Auth.auth().addStateDidChangeListener { auth, user in
            
            if let user = user { // User is signed in.
                let uid = user.uid;
                print("uid: \(uid)")
                
                DAO.CST_GOALS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                    
                    if snapshot.key == "numberOfKeys" {
                        print("to no numberOfKeys-CST")
                        
                        totalCstGoalsThisUser = snapshot.value as! Int
                        print("totalCstGoalsThisUser = \(totalCstGoalsThisUser)")
                        
                        completionHandlerGoals(numberCompleted, totalCstGoalsThisUser, totalStdGoals)
                    }
                    else {
                        self.goals.append(Goal(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>))
                        
                        numberCompleted += 1
                        completionHandlerGoals(numberCompleted, totalCstGoalsThisUser, totalStdGoals)
                    }
                })
            }
        })
        Auth.auth().removeStateDidChangeListener(handle)

        
        // pega os goals do banco e os armazena no array goals
        DAO.STD_GOALS_REF.observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                print("to no numberOfKeys-STD")
                
                totalStdGoals = snapshot.value as! Int
                
                print("totalStdGoals = \(totalStdGoals)")
                
                completionHandlerGoals(numberCompleted, totalCstGoalsThisUser, totalStdGoals)
            }
            else {
                self.goals.append(Goal(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>))
                
                numberCompleted += 1
                completionHandlerGoals(numberCompleted, totalCstGoalsThisUser, totalStdGoals)
            }
        })
    }
    
    // função que pega apenas os std goals
    func handleAsynchronousRequestForEveryStdGoal (completionHandlerGoals: @escaping (_ numberCompleted: Int, _ totalStdGoals: Int) -> Void) {
        
        var numberCompleted = 0
        var totalStdGoals = -10
        
        // pega os goals do banco e os armazena no array goals
        DAO.STD_GOALS_REF.observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                print("to no numberOfKeys-STD")
                
                totalStdGoals = snapshot.value as! Int
                
                print("totalStdGoals = \(totalStdGoals)")
                
                completionHandlerGoals(numberCompleted, totalStdGoals)
            }
            else {
                self.goals.append(Goal(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>))
                
                numberCompleted += 1
                completionHandlerGoals(numberCompleted, totalStdGoals)
            }
        })
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToConfigFromGoals" {
            
            let svc = segue.destination as! ConfigViewController
            // customization:
            svc.modalTransition.edge = .right
            svc.modalTransition.radiusFactor = 0.3
        }
        
        if segue.identifier == "goToCurrentStep" {
            
            let cell = sender as! GoalCollectionViewCell
            let indexPath = goalsCollectionView?.indexPath(for: cell)
            let goal = goals[(indexPath! as NSIndexPath).item]
            let currentStepVC = segue.destination as! CurrentStepViewController
            
            currentStepVC.goal = goal.name
            currentStepVC.step = goal.firstStep.name
            currentStepVC.goalKey = goal.key
            
            // seta o step atual do usuário como 1 -- saber se view inicial é a de goals ou a de currentStep
            var handle : AuthStateDidChangeListenerHandle
            
            handle = (Auth.auth().addStateDidChangeListener { auth, user in
                if let user = user {
                    // User is signed in.
                    let uid = user.uid;
                    
                    DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                        
                        if snapshot.key == "currentStepNumber" {
                            let childUpdates = [snapshot.key: "1"]
                            DAO.USERS_REF.child(uid).updateChildValues(childUpdates)
                        }
                        
                        if snapshot.key == "currentGoalKey" {
                            let childUpdates = [snapshot.key: goal.key]
                            DAO.USERS_REF.child(uid).updateChildValues(childUpdates)
                        }
                        
                    })
                }
            })
            
            Auth.auth().removeStateDidChangeListener(handle)
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let rootVC = appDelegate.window!.rootViewController
            
            if (type(of: rootVC!) == type(of: self) || (String(describing: type(of: rootVC!)) == "LoginViewController" && self.isSecondVC == true)) {
                print("MA OE GOALSVC")
                //self.isSecondVC = false
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "currentStepVC")
                self.present(vc, animated: true, completion: nil)
            }
            else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
}
