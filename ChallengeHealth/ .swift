import UIKit
import Firebase
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FIRApp.configure()
        
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
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainStoryboard.instantiateViewController(withIdentifier: "goalsVC")
                            self.window?.rootViewController = vc
                        }
                        else {
                            self.window = UIWindow(frame: UIScreen.main.bounds)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainStoryboard.instantiateViewController(withIdentifier: "currentStepVC")
                            self.window?.rootViewController = vc
                        }
                        
                        self.window?.makeKeyAndVisible()
                    }
                    
                })
            }
            else {
                print("OIR")
                self.window = UIWindow(frame: UIScreen.main.bounds)
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainStoryboard.instantiateViewController(withIdentifier: "loginVC")
                self.window?.rootViewController = vc
                
                self.window?.makeKeyAndVisible()
            }
            })!
        
        FIRAuth.auth()?.removeStateDidChangeListener(handle)
        
        return true
    }
    
}
