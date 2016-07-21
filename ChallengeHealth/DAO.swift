import Foundation
import Firebase
import FirebaseAuth

let rootReference = FIRDatabase.database().reference()

class DAO {
    
    static var BASE_REF = rootReference
    static var STD_GOALS_REF = rootReference.child("standardGoals")
    static var STD_STEPS_REF = rootReference.child("standardSteps")

    static func signUp(email: String, password: String, callback: FIRAuthResultCallback) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: callback)
    }
    
    static func login(username: String, password: String, callback: FIRAuthResultCallback) {
        FIRAuth.auth()?.signInWithEmail(username, password: password, completion: callback)
    }
    
//    static func fetchStdGoalsFromServer(callback: (Goal) -> ()) {
//        DAO.STD_GOALS_REF.observeEventType(.ChildAdded, withBlock: { (snapshot) in
//            let goal = Goal(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>)
//            callback(goal)
//        })
//    }
    
}