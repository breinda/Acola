

import Foundation
import Firebase
import FirebaseAuth

//let roofRef = FIRDatabase.database().reference()

class DAO {
    
//    static let dataService = DataService()
//    
//    private var _BASE_REF = roofRef
//    private var _REQUEST_REF = roofRef.child("requests")
//    //private var _MESSAGE_REF = roofRef.child("messages")
//    private var _PEOPLE_REF = roofRef.child("people")
    
    var currentUser: FIRUser? {
        return FIRAuth.auth()!.currentUser!
    }
    
//    var BASE_REF: FIRDatabaseReference {
//        return _BASE_REF
//    }
//    
//    var REQUEST_REF: FIRDatabaseReference {
//        return _REQUEST_REF
//    }
//    
//    var storageRef: FIRStorageReference {
//        return FIRStorage.storage().reference()
//    }
//    
//    var PEOPLE_REF: FIRDatabaseReference {
//        return _PEOPLE_REF
//    }
//    
    var fileUrl: String!
    
    
    
//    func Create(user: FIRUser, name: String, detail: String){
//        
//        if let user = FIRAuth.auth()?.currentUser {
//            let idRoom = self.BASE_REF.child("requests").childByAutoId()
//            idRoom.setValue(["name": name, "detail": detail, "fileUrl": self.fileUrl])
//        }
//        
//    }
    
//    static func fetchDataFromServer(callback: (Request) -> ()) {
//        DAO.REQUEST_REF.observeEventType(.ChildAdded, withBlock: { (snapshot) in
//            let request = Request(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>)
//            callback(request)
//        })
//    }
    
    
    
    // Sign Up
    static func signUp(email: String, password: String, callback: FIRAuthResultCallback) {
        FIRAuth.auth()?.createUserWithEmail(email, password: password, completion: callback)
    }
    
    // Login
    static func login(username: String, password: String, callback: FIRAuthResultCallback) {
        FIRAuth.auth()?.signInWithEmail(username, password: password, completion: callback)
    }
    
}