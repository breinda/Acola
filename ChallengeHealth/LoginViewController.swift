import UIKit
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
//                let alertView = UIAlertController(title: "NOIX!", message: "LOGIN FEITO COM SUCESSO CAROLHO" as String, preferredStyle:.ActionSheet)
//                let okAction = UIAlertAction(title: "YES", style: .Default, handler: nil)
//                alertView.addAction(okAction)
//                self.presentViewController(alertView, animated: true, completion: nil)
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