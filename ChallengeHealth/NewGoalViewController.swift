//
//  NewGoalViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 24/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}


class NewGoalViewController: ElasticModalViewController, UITextViewDelegate {

    @IBOutlet weak var backRectangleImageView: UIImageView!
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var boddiImageView: UIImageView!
    @IBOutlet weak var navBarRectangleImageView: UIImageView!
    @IBOutlet weak var goalRectangleImageView: UIImageView!
    
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var boddiTextView: UITextView!
    
    var placeholder : String = "seu objetivo!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setando propriedades das imagens
        backRectangleImageView.layer.cornerRadius = 39
        backRectangleImageView.layer.borderWidth = 1
        backRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        
        navBarRectangleImageView.layer.borderWidth = 1
        navBarRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        
        goalRectangleImageView.layer.borderWidth = 1
        goalRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        bubbleImageView.layer.cornerRadius = 26
        bubbleImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        bubbleImageView.layer.shadowOpacity = 0.1
        bubbleImageView.layer.shadowRadius = 4
        bubbleImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bubbleImageView.layer.shouldRasterize = true
        
        boddiImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        boddiImageView.layer.shadowOpacity = 0.1
        boddiImageView.layer.shadowRadius = 4
        boddiImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        boddiImageView.layer.shouldRasterize = true
        
        // setando propriedades da goalTextView
        goalTextView.text = placeholder
        goalTextView.keyboardAppearance = .dark
        goalTextView.delegate = self
        self.hideKeyboardWhenTappedAround()

        boddiTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goalTextView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        goalTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    // MARK: Text View Properties
    
    // force the text in a UITextView to always center itself.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }
    
    // faz com que a textView apareça scrollada a partir do início
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        boddiTextView.setContentOffset(CGPoint.zero, animated: false)
        //goalTextView.setContentOffset(CGPoint.zero, animated: false)
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholder {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = placeholder
        }
    }
    
    
    // MARK: Navigation
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        
        //        var transition = ElasticTransition()
        //        transition.edge = .left
        //        transition.radiusFactor = 0.3
        
        self.modalTransition.edge = .right
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // cria novo objetivo para o ID do usuário e vai para a tela de edição de Objetivo.
    // Por enquanto, utiliza-se o NOME do objetivo como ID.
    // TODO: Caso um Objetivo com esse nome já exista, sugerir edição do Objetivo já existente?
    @IBAction func OKButtonWasTapped(_ sender: Any) {
        
        if (goalTextView.text == "") {
            boddiTextView.text = "Qual é mesmo o nome de seu novo Objetivo?"
        }

        else {
            
            //var confirmCstGoalHasNOTBeenCreated = 0
            
            handleAsynchronousRequest(completionHandlerCstGoalHasNotBeenCreated: { keyCounter, cstGoalHasBeenCreated in
                if (cstGoalHasBeenCreated == 0) {
                    
                    print("EITA não foi criado nenhum Goal ainda")
                    print("cstGoalHasBeenCreated = \(cstGoalHasBeenCreated)")
                    
                    // vamos criar uma nova entrada no banco de acordo com a key do usuário
                    
                    var handle : AuthStateDidChangeListenerHandle
                    
                    handle = (Auth.auth().addStateDidChangeListener { auth, user in
                        
                        if let user = user {
                            // User is signed in.
                            let uid = user.uid;
                            print("uid: \(uid)")
                            
                            //let key = uid
                            let goalKey = String(self.goalTextView.text)!
                            
                            let childUpdates = ["\(uid)": goalKey]
                            DAO.CST_GOALS_REF.updateChildValues(childUpdates)
                        }
                    })
                    Auth.auth().removeStateDidChangeListener(handle)
                    
//                    // precisamos também atualizar o valor da entrada numberOfKeys no banco
                    DAO.CST_GOALS_REF.observe(.childAdded, with: { (snapshot) in
                        
                        print(snapshot.key)
                        
                        let key = String(snapshot.key)
                        
                        if key == "numberOfKeys" {
                            print("achei o keyNumber!!AEEAEE")
                            
                            print(snapshot.value)
                            
                            var keyNumber = Int(String(describing: snapshot.value!))!
                            print("keyNumber ANTES = \(keyNumber)")
                            keyNumber += 1
                            print("keyNumber DEPOIS = \(keyNumber)")
                            
                            let childUpdates = ["\(String(describing: key!))" : String(keyNumber)]
                            DAO.CST_GOALS_REF.updateChildValues(childUpdates)
                        }
                    })
                    
                }
                    
                else {
                    print("OUI o usuário já possui um Goal criado")
                    print("cstGoalHasBeenCreated = \(cstGoalHasBeenCreated)")
                }
            })
        }
    }

    
    func handleAsynchronousRequest (completionHandlerCstGoalHasNotBeenCreated: @escaping (_ keyCounter: Int, _ cstGoalHasBeenCreated: Int) -> Void) {
        var handle : AuthStateDidChangeListenerHandle
        
        handle = (Auth.auth().addStateDidChangeListener { auth, user in
            
            if let user = user {
                // User is signed in.
                //let name = user.displayName
                //let email = user.email
                let uid = user.uid;
                print("uid: \(uid)")
                
                var cstGoalHasBeenCreated : Int = 0
                var keyCounter : Int = 0
                var keyNumber : Int = -10
                
                //let key = uid
                let goalKey = String(self.goalTextView.text)!
                
                DAO.CST_GOALS_REF.observe(.childAdded, with: { (snapshot) in
                    
                    //print(snapshot.key)
                    keyCounter += 1
                    //print("keyCounter = \(keyCounter)")
                    
                    let key = String(snapshot.key)
                    
                    if snapshot.key == "numberOfKeys" {
                        //print("achei o keyNumber!!")
                        keyNumber = Int(String(describing: snapshot.value!))!
                        //print("keyNumber = \(keyNumber)")
                    }
                    
                    if (keyCounter - 1) == keyNumber {
                        completionHandlerCstGoalHasNotBeenCreated(keyCounter, cstGoalHasBeenCreated)
                    }
                    
                    if (key == uid) { // usuário já criou algum objetivo
                        cstGoalHasBeenCreated += 1
                        //completionHandlerCstGoalHasBeenCreated(cstGoalHasBeenCreated)
                        
                        let childUpdates = ["\(goalKey)" : ""]
                        DAO.CST_GOALS_REF.child(key!).updateChildValues(childUpdates)
                        
                        completionHandlerCstGoalHasNotBeenCreated(keyCounter, cstGoalHasBeenCreated)
                    }
                })
                
                //                    let goalData = ["description": "", "firstStep": ["description": "", "name": ""], "name": goalKey] as [String : Any]
                //                    let childChildUpdates = ["\(goalKey)": goalData]
                //
                //                    DAO.CST_GOALS_REF.child(goalKey).updateChildValues(childChildUpdates)
            }
        })
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
}
