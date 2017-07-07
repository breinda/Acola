import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTextSpacing(spacing: 1.5)
        emailTextField.keyboardAppearance = .dark
        passwordTextField.keyboardAppearance = .dark
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginButtonWasTapped(_ sender: AnyObject) {
        let email = emailTextField.text
        let password = passwordTextField.text
        
        activityIndicatorView.startAnimating()
        
        
        if (email == "" || password == "") {
            let alertView = UIAlertController(title: "Problema no login",
                                              message: "Preencha todos os campos." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            
            self.activityIndicatorView.stopAnimating()
            return;
        }
        
        
        // LOGIN
        Auth.auth().signIn(withEmail: email!, password: password!) { (user, error) in
            
            print("ERRO: \(error)")
            
            // SUCESSO!!
            if error == nil {
                var handle : AuthStateDidChangeListenerHandle
                
                handle = (Auth.auth().addStateDidChangeListener { auth, user in
                    if let user = user {
                        // User is signed in.
                        let uid = user.uid;
                        
                        print("uid: \(uid)")
                        
                        DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
                            
                            // faz com a view inicial seja a de Goals, se o usuário não tiver escolhido nenhum goal, e que seja a de Steps, caso contrário
                            
                            if snapshot.key == "currentStepNumber" {
                                
                                let userStepNumber = snapshot.value as! String
                                
                                if userStepNumber == "0" {
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let rootVC = appDelegate.window!.rootViewController
                                    
                                    if (type(of: rootVC!) == type(of: self)) {
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewController(withIdentifier: "goalsVC") as! GoalsViewController
                                        vc.isSecondVC = true
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                    else {
                                        self.dismiss(animated: false, completion: nil)
                                    }
                                    self.activityIndicatorView.stopAnimating()
                                }
                                else {
                                    let appDelegate = UIApplication.shared.delegate as! AppDelegate
                                    let rootVC = appDelegate.window!.rootViewController
                                    
                                    if (type(of: rootVC!) == type(of: self)) {
                                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyboard.instantiateViewController(withIdentifier: "currentStepVC") as! CurrentStepViewController
                                        vc.isSecondVC = true
                                        self.present(vc, animated: true, completion: nil)
                                    }
                                    else {
                                        self.dismiss(animated: false, completion: nil)
                                    }
                                    self.activityIndicatorView.stopAnimating()
                                }
                            }
                        })
                    }
                })
                
                Auth.auth().removeStateDidChangeListener(handle)
            }
                
                // DEU RUIM
            else {
                let alert = UIAlertController(title: "Problema no login", message: "Combinação email-senha não reconhecida.", preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        
        /*
         func loginCallback (_ user: FIRUser?, error: NSError?) {
         // SUCESSO !!!
         if error == nil {
         var handle : FIRAuthStateDidChangeListenerHandle
         
         handle = (FIRAuth.auth()?.addStateDidChangeListener { auth, user in
         if let user = user {
         // User is signed in.
         let uid = user.uid;
         
         DAO.USERS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
         
         // faz com a view inicial seja a de Goals, se o usuário não tiver escolhido nenhum goal, e que seja a de Steps, caso contrário
         
         if snapshot.key == "currentStepNumber" {
         
         let userStepNumber = snapshot.value as! String
         
         if userStepNumber == "0" {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let rootVC = appDelegate.window!.rootViewController
         
         if (type(of: rootVC!) == type(of: self)) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "goalsVC") as! GoalsViewController
         vc.isSecondVC = true
         self.present(vc, animated: true, completion: nil)
         }
         else {
         self.dismiss(animated: false, completion: nil)
         }
         self.activityIndicatorView.stopAnimating()
         }
         else {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let rootVC = appDelegate.window!.rootViewController
         
         if (type(of: rootVC!) == type(of: self)) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "currentStepVC") as! CurrentStepViewController
         vc.isSecondVC = true
         self.present(vc, animated: true, completion: nil)
         }
         else {
         self.dismiss(animated: false, completion: nil)
         }
         self.activityIndicatorView.stopAnimating()
         }
         }
         })
         }
         })!
         
         FIRAuth.auth()?.removeStateDidChangeListener(handle)
         }
         // DEU RUIM
         else {
         let alert = UIAlertController(title: "Problema no login", message: "Combinação email-senha não reconhecida.", preferredStyle: UIAlertControllerStyle.alert)
         let cancel = UIAlertAction(title: "Tentar novamente", style: UIAlertActionStyle.cancel, handler: nil)
         
         alert.addAction(cancel)
         self.present(alert, animated: true, completion: nil)
         self.activityIndicatorView.stopAnimating()
         }
         }*/
        
        //DAO.login(email!, password: password!, callback: loginCallback as! FIRAuthResultCallback)
        
    }
}
