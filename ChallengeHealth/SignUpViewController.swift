import UIKit
import Firebase
import FirebaseAuth

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}


class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    
    // @IBOutlet weak var boddi: BoddiView!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailPasswordView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    //@IBOutlet weak var confirmEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var boddiTextBubbleLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        
        //  boddi.addAppearHappyAnimation()
        //ADICIONAR ciclo depois. agora não está funcionando nao faco ideia do porquê, nao aparece nem a animaçao inicial.
        
        emailPasswordView.isHidden = true
        
        nameTextField.keyboardAppearance = .dark
        emailTextField.keyboardAppearance = .dark
        //confirmEmailTextField.keyboardAppearance = .dark
        passwordTextField.keyboardAppearance = .dark
        confirmPasswordTextField.keyboardAppearance = .dark
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    // MARK: - navigation
    
    // return = back button
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        
        if emailPasswordView.isHidden == true {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            emailPasswordView.isHidden = true
            nameView.isHidden = false
        }
        
        // esconde o teclado
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    @IBAction func confirmNameButtonWasTapped(_ sender: AnyObject) {
        let name = nameTextField.text
        
        if name!.isEmpty {
            boddiTextBubbleLabel.text! = "Por favor, me diga o seu nome!"
            return;
        }
        
        nameView.isHidden = true
        returnButton.isHidden = false
        emailPasswordView.isHidden = false
        
        boddiTextBubbleLabel.text! = "Oi, \(name!)! Por favor, insira seus dados para podermos continuar."
        
        // esconde o teclado
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
    
    // MARK: cadastro
    // função auxiliar para analisar formataçao do email com regex
    func containsMatch(_ pattern: String, inString string: String) -> Bool {
        
        let regex : NSRegularExpression
        
        do {
            regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            let range = NSMakeRange(0, string.characters.count)
            
            return regex.numberOfMatches(in: string, options: NSRegularExpression.MatchingOptions.reportProgress, range: range) != 0
            
        } catch {
            print("erro ao criar regex")
            return false
        }
    }
    
    
    @IBAction func signUpButtonWasTapped(_ sender: AnyObject) {
        
        let name = nameTextField.text
        let email = emailTextField.text
        //let confirmEmail = confirmEmailTextField.text
        let password = passwordTextField.text
        let confirmPassword = confirmPasswordTextField.text
        
        
        // ALERTS PRA PROBLEMAS NO CADASTRO
        if (name!.isEmpty || email!.isEmpty || password!.isEmpty || confirmPassword!.isEmpty) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Preencha todos os campos." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            
            return;
        }
        
        if (!containsMatch("([^\\t\\n\\s])*@([^\\t\\n\\s])*\\.([^\\t\\n\\s])*", inString: email!)) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Formato de email não reconhecido." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            
            return;
        }
        
//        if (email != confirmEmail) {
//            
//            let alertView = UIAlertController(title: "Problema no cadastro",
//                                              message: "Os emails inseridos não coincidem." as String, preferredStyle:.alert)
//            let okAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: nil)
//            alertView.addAction(okAction)
//            self.present(alertView, animated: true, completion: nil)
//            
//            return;
//        }
        
        if (password != confirmPassword) {
            
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "As senhas inseridas não coincidem." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            
            return;
        }
        
        if (password?.characters.count < 6) {
            let alertView = UIAlertController(title: "Problema no cadastro",
                                              message: "Senha com menos de 6 caracteres." as String, preferredStyle:.alert)
            let okAction = UIAlertAction(title: "Tentar novamente", style: .default, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
            return;
        }
        
        
        // CADASTRO
        Auth.auth().createUser(withEmail: email!, password: password!) { (user, error) in
            
            print("ERRO: \(error)")
            
            if error == nil {
                
                let alert = UIAlertController(title: "SUCESSO", message: "Cadastro efetuado com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
                
                let cancel = UIAlertAction(title: "OK!", style: UIAlertActionStyle.cancel, handler: { action in
                    
                    self.dismiss(animated: true, completion: nil)
                })
                
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                
                // popula o database com os dados iniciais do usuário no ato do cadastro
                var handle : AuthStateDidChangeListenerHandle
                
                handle = (Auth.auth().addStateDidChangeListener { auth, user in
                    
                    if let user = user {
                        // User is signed in.
                        //let name = user.displayName
                        let email = user.email
                        let uid = user.uid;
                        
                        print("email: \(email!)")
                        print("uid: \(uid)")
                        
                        let key = uid
                        let userData = ["name": name!, "petName": "Serumaninho", "currentGoalKey": "", "currentStepNumber": "0", "customGoals": false] as [String : Any]
                        let childUpdates = ["\(key)": userData]
                        
                        DAO.USERS_REF.updateChildValues(childUpdates)
                    }
                })
                
                Auth.auth().removeStateDidChangeListener(handle)
            }
                
            else { // encontrou um erro
                
                let alert = UIAlertController(title: "Erro", message: "vc conseguiu a façanha de achar um erro que eu não tratei???", preferredStyle: UIAlertControllerStyle.alert)
                
                let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
                
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
