import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        FIRApp.configure()
        
        var handle : FIRAuthStateDidChangeListenerHandle
        
        handle = (FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            if let user = user {
                // User is signed in.
                let uid = user.uid;
                print("qqqqqqqq")
                
                DAO.USERS_REF.child(uid).observeEventType(.ChildAdded, withBlock: { (snapshot) in
                    
                    // faz com a view inicial seja a de Goals, se o usuário não tiver escolhido nenhum goal, e que seja a de Steps, caso contrário
                    
                    if snapshot.key == "currentStepNumber" {
                        
                        let userStepNumber = snapshot.value as! String
                        
                        if userStepNumber == "0" {
                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("GoalsVC")
                            self.window?.rootViewController = vc
                        }
                        else {
                            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("currentStepVC")
                            self.window?.rootViewController = vc
                        }
                        
                        self.window?.makeKeyAndVisible()
                    }
                    
                })
            }
            else {
                print("OIR")
                self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = mainStoryboard.instantiateViewControllerWithIdentifier("LoginVC")
                self.window?.rootViewController = vc
                
                self.window?.makeKeyAndVisible()
            }
        })!
        
        FIRAuth.auth()?.removeAuthStateDidChangeListener(handle)
        
//         if FIRAuth.auth()?.currentUser == nil {
//            print("OIR")
//            self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let vc = mainStoryboard.instantiateViewControllerWithIdentifier("LoginVC")
//            self.window?.rootViewController = vc
//        }
        
        
        return true
    }
    
}