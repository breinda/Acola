import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonWasTapped(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        
        if (email == "" || password == "") {
            let alertView = UIAlertController(title: "Problema no login",
                                              message: "Preencha todos os campos." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        func loginCallback (user: FIRUser?, error: NSError?) {
            // SUCESSO !!!
            if error == nil {
                var handle : FIRAuthStateDidChangeListenerHandle
                
                handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if let user = user {
                        // User is signed in.
                        let uid = user.uid;
                        
                        DAO.USERS_REF.child(uid).observeEventType(.ChildAdded, withBlock: { (snapshot) in
                            
                            // faz com a view inicial seja a de Goals, se o usuário não tiver escolhido nenhum goal, e que seja a de Steps, caso contrário
                            
                            if snapshot.key == "currentStepNumber" {
                                
                                let userStepNumber = snapshot.value as! String
                                
                                if userStepNumber == "0" {
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewControllerWithIdentifier("goalsVC")
                                    self.presentViewController(vc, animated: false, completion: nil)
                                }
                                else {
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyboard.instantiateViewControllerWithIdentifier("currentStepVC")
                                    self.presentViewController(vc, animated: false, completion: nil)
                                }
                            }
                        })
                    }
                })!
                
                FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)

                self.dismissViewControllerAnimated(true, completion: nil)
            }
            // DEU RUIM
            else {
                let alert = UIAlertController(title: "Problema no login", message: "Combinação email-senha não reconhecida.", preferredStyle: UIAlertControllerStyle.Alert)
                let cancel = UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(cancel)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        DAO.login(email!, password: password!, callback: loginCallback)
    }
    
}