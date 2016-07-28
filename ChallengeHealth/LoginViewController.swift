import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonWasTapped(sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        activityIndicatorView.startAnimating()
        
        
        if (email == "" || password == "") {
            let alertView = UIAlertController(title: "Problema no login",
                                              message: "Preencha todos os campos." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
            self.activityIndicatorView.stopAnimating()
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
                                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                    let rootVC = appDelegate.window!.rootViewController
                                    
                                    if (rootVC!.dynamicType == self.dynamicType) {
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewControllerWithIdentifier("goalsVC") as! GoalsViewController
                                        vc.isSecondVC = true
                                        self.presentViewController(vc, animated: true, completion: nil)
                                    }
                                    else {
                                        self.dismissViewControllerAnimated(false, completion: nil)
                                    }
                                    self.activityIndicatorView.stopAnimating()
                                }
                                else {
                                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                                    let rootVC = appDelegate.window!.rootViewController

                                    if (rootVC!.dynamicType == self.dynamicType) {
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewControllerWithIdentifier("currentStepVC") as! CurrentStepViewController
                                        vc.isSecondVC = true
                                        self.presentViewController(vc, animated: true, completion: nil)
                                    }
                                    else {
                                        self.dismissViewControllerAnimated(false, completion: nil)
                                    }
                                    self.activityIndicatorView.stopAnimating()
                                }
                            }
                        })
                    }
                })!
                
                FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
            }
            // DEU RUIM
            else {
                let alert = UIAlertController(title: "Problema no login", message: "Combinação email-senha não reconhecida.", preferredStyle: UIAlertControllerStyle.Alert)
                let cancel = UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(cancel)
                self.presentViewController(alert, animated: true, completion: nil)
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        DAO.login(email!, password: password!, callback: loginCallback)
    }
    
}