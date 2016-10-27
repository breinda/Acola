import Foundation
import Firebase
import FirebaseAuth

let rootReference = FIRDatabase.database().reference()

class DAO {
    
    static var BASE_REF = rootReference
    static var STD_GOALS_REF = rootReference.child("standardGoals")
    static var STD_STEPS_REF = rootReference.child("standardSteps")
    static var USERS_REF = rootReference.child("users")

    static func signUp(_ email: String, password: String, callback: @escaping FIRAuthResultCallback) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: callback)
    }
    
    static func login(_ username: String, password: String, callback: @escaping FIRAuthResultCallback) {
        FIRAuth.auth()?.signIn(withEmail: username, password: password, completion: callback)
    }
}
