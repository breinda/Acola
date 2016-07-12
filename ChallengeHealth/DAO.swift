import Foundation
import Firebase
import FirebaseAuth

class DAO {

    static func signUp(email: String, password: String, callback: FIRAuthResultCallback) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: callback)
    }
    
    static func login(username: String, password: String, callback: FIRAuthResultCallback) {
        FIRAuth.auth()?.signInWithEmail(username, password: password, completion: callback)
    }
    
}