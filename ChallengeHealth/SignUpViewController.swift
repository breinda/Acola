import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    

    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailPasswordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        emailPasswordView.hidden = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func returnButtonWasTapped(sender: AnyObject) {
        
        if emailPasswordView.hidden == true {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            emailPasswordView.hidden = true
            nameView.hidden = false
        }
    }
    
    @IBAction func confirmNameButtonWasTapped(sender: AnyObject) {
        
        nameView.hidden = true
        returnButton.hidden = false
        emailPasswordView.hidden = false
    }
    
    // função auxiliar para analisar regex
    func containsMatch(pattern: String, inString string: String) -> Bool {
        
        let regex : NSRegularExpression
        
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            
            let range = NSMakeRange(0, string.characters.count)
            
            return regex.numberOfMatchesInString(string, options: NSMatchingOptions.ReportProgress, range: range) != 0
            
        } catch {
            print("erro ao criar regex")
            return false
        }
    }
    
    @IBAction func signUpButtonWasTapped(sender: AnyObject) {
        
        let name = nameTextField.text
        let email = emailTextField.text
        let confirmEmail = confirmEmailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        
        // ALERTS PRA PROBLEMAS NO CADASTRO
        if (name!.isEmpty || email!.isEmpty || password!.isEmpty || confirmPassword!.isEmpty) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Preencha todos os campos." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
            return;
        }
        
        if (!containsMatch("([^\\t\\n\\s])*@([^\\t\\n\\s])*\\.([^\\t\\n\\s])*", inString: email!)) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Formato de email não reconhecido." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
            return;
        }
        
        if (email != confirmEmail) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Os emails inseridos não coincidem." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
            return;
        }
        
        if (password != confirmPassword) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "As senhas inseridas não coincidem." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            
            return;
        }
        
        if (password?.characters.count < 6) {
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Senha com menos de 6 caracteres." as String, preferredStyle:.Alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .Default, handler: nil)
            alertView.addAction(okAction)
            self.presentViewController(alertView, animated: true, completion: nil)
            return;
        }
        
        
        // FUNCAO DE CALLBACK
        func registerCallback (user: FIRUser?, error: NSError?) {
            if error == nil {
                let alert = UIAlertController(title: "SUCESSO", message: "Cadastro efetuado com sucesso!", preferredStyle: UIAlertControllerStyle.Alert)
                
                let cancel = UIAlertAction(title: "OKAY!", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(cancel)
                self.presentViewController(alert, animated: true, completion: nil)
                
                // popula o database com os dados iniciais do usuário no ato do cadastro
                var handle : FIRAuthStateDidChangeListenerHandle
        
                handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
                    if let user = user {
                        // User is signed in.
                        //let name = user.displayName
                        let email = user.email
                        let uid = user.uid;

                        print("email")
                        print(email)
                        print("uid")
                        print(uid)
                        
                        let key = uid
                        let userData = ["name": name!, "petName": "Serumaninho", "currentGoalKey": "", "currentStepNumber": "0", "customGoals": false]
                        let childUpdates = ["\(key)": userData]
                        
                        DAO.USERS_REF.updateChildValues(childUpdates)
                    }
                })!
                
                FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
            }
            else {
                let alert = UIAlertController(title: "Erro", message: "vc conseguiu a façanha de achar um erro que eu não tratei???", preferredStyle: UIAlertControllerStyle.Alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
                
                alert.addAction(cancel)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
        
        DAO.signUp(email!, password: password!, callback: registerCallback)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}