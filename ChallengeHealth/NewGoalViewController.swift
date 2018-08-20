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
    
    @objc func dismissKeyboard() {
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
        backRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        
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
        goalTextView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        goalTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // passar o nome do goal pra tela de edição
        if segue.identifier == "goToGoalEditingFromNewGoal" {
            
            let goalText: String = goalTextView.text!
            let goalEditingVC = segue.destination as! GoalEditingViewController
            
            print("goalText = \(goalText)")
            print("goalEditingVC.placeholderStr = \(goalEditingVC.placeholderStr)")
            
            goalEditingVC.placeholderStr = goalText
        }
    }
    
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
        
        print("CLIQUEI NO OK")
        
        let nomeObj = goalTextView.text
        let invalidChars = [".", "#", "$", "[", "]"]
        
        // Objetivo sem nome!
        if nomeObj == "" {
            boddiTextView.text = "Qual é mesmo o nome de seu novo Objetivo?"
        }
            
        // nome do Objetivo contendo '.', '#', '$', '[' ou ']'
        else if (nomeObj!.range(of: ".") != nil) || (nomeObj!.range(of: "#") != nil) || (nomeObj!.range(of: "$") != nil) || (nomeObj!.range(of: "[") != nil) || (nomeObj!.range(of: "]") != nil) {
            boddiTextView.text = "Hmm, o nome de seu Objetivo possui algum símbolo inválido. Por favor, tente novamente!"
            
            for invalidChar in invalidChars {
                if nomeObj!.range(of: invalidChar) != nil {
                    boddiTextView.text = "Ah, o nome de seu Objetivo não pode conter o símbolo '\(invalidChar)' . Por favor, tente novamente!"
                }
            }
        }
        
        // tudo ok!
        else {
            handleAsynchronousRequestForCstGoalsFromThisUserAtNewGoalVC { numberCompleted, totalUsersWithCstGoals, userWasFound in
                
                print("numberCompleted = \(numberCompleted)")
                print("totalUsersWithCstGoals = \(totalUsersWithCstGoals)")
                print("userWasFound = \(userWasFound)")
                print("")
                
                if numberCompleted == totalUsersWithCstGoals { // se tivermos chegado ao fim da busca
                    DAO.CST_GOALS_REF.removeAllObservers()
                    
                    print("1 - cheguei no final da busca pelo usuario")
                    
                    if userWasFound == true { // usuário possui algum custom goal criado!
                        print("2 - no final da busca, ACHEI o usuario")
                        print("2 - achei o usuário AFINAL -- usuário possui ALGUM custom goal já criado")
                        
                        // TO DO: antes, vamos ver se já existe um goal com esse nome
                        
                        // agora, precisamos apenas escrever um goal novo na árvore do usuário
                        self.handleAsynchronousRequestForNewCstGoalWithExistingTree { numberCompleted in
                            
                            if numberCompleted == 4 {
                                print("4 - userWasFound == TRUE -- PRONTO!! -- criei goal novo na árvore (já existente) do usuário!!")
                                print("4 - numberCompleted = \(numberCompleted)")
                                
                                DAO.CST_GOALS_REF.removeAllObservers()
                                DAO.CST_STEPS_REF.removeAllObservers()
                                
                                GoalsVCShouldReload = true

                                self.performSegue(withIdentifier: "goToGoalEditingFromNewGoal", sender: self)
                            }
                            else {
                                print("3 - userWasFound == TRUE -- LOADING -- ainda estou botando coisas no banco TENHA PACIENCIA -- VOU CRIAR goal novo na árvore (já existente) do usuário!!")
                            }
                        }
                    }
                    else { // não achamos o usuário ao final da busca == usuário não possui nenhum custom goal criado
                        
                        print("2 - no final da busca, NÃAAO ACHEI o usuario")
                        
                        // precisamos criar a árvore do usuário
                        self.handleAsynchronousRequestForNewUserCstGoalsTree { numberCompleted in
                            
                            if numberCompleted == 4 {
                                print("4 - userWasFound == FALSE -- PRONTO!! -- criei árvore nova para usuário e meti goal novo lá!!")
                                print("4 - numberCompleted = \(numberCompleted)")
                                
                                DAO.CST_GOALS_REF.removeAllObservers()
                                DAO.CST_STEPS_REF.removeAllObservers()
                                
                                GoalsVCShouldReload = true
                                
                                self.performSegue(withIdentifier: "goToGoalEditingFromNewGoal", sender: self)
                            }
                            else {
                                print("3 - userWasFound == FALSE -- LOADING -- ainda estou botando coisas no banco TENHA PACIENCIA -- VOU CRIAR árvore nova para usuário e meter goal novo lá!!")
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: Handlers for Asynchronous Stuff

    // checa se o usuário corrente possui algum custom goal criado
    func handleAsynchronousRequestForCstGoalsFromThisUserAtNewGoalVC (completionHandlerUsers: @escaping (_ numberCompleted: Int, _ totalUsersWithCstGoals: Int, _ userWasFound: Bool) -> Void) {
        var numberCompleted = 0
        var totalUsersWithCstGoals = -10
        var userWasFound = false
        
        // procura saber se usuário possui custom goals criados
        let uid = userID
        //print("uid: \(uid)")
        
        let handle = DAO.CST_GOALS_REF.observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                //print("to no numberOfKeys-USERS WITH CST GOALS")
                
                totalUsersWithCstGoals = snapshot.value as! Int
                print("achei o total de Users com CST_GOALS = \(totalUsersWithCstGoals)")
                
                completionHandlerUsers(numberCompleted, totalUsersWithCstGoals, userWasFound)
            }
            else {
                if snapshot.key == uid { // usuário encontrado na lista = usuário possui algum custom goal criado
                    userWasFound = true
                    completionHandlerUsers(numberCompleted, totalUsersWithCstGoals, userWasFound)
                }
                
                numberCompleted += 1
                completionHandlerUsers(numberCompleted, totalUsersWithCstGoals, userWasFound)
            }
        })
        
        //DAO.CST_GOALS_REF.removeObserver(withHandle: handle)
    }
    
    // usuário NÃO possui goal nenhum criado
    // cria nova árvore para o usuário em CST_GOALS e insere goal novo. atualiza numberOfKeys do CST_GOALS. cria numberOfKeys da árvore do usuário em CST_STEPS e seta o valor inicial como 1.
    // cria, também, nova árvore para o usuário em CST_STEPS e insere Step vazio. atualiza numberOfKeys do CST_STEPS. cria numberOfKeys da árvore do usuário em CST_STEPS e seta o valor inicial como 1.
    func handleAsynchronousRequestForNewUserCstGoalsTree (completionHandlerUsers: @escaping (_ numberCompleted: Int) -> Void) {
        var numberCompleted = 0
        let uid = userID
        //print("uid: \(uid)")
        
        // cria nova entrada na CST_GOALS com uid do usuário. insere goal novo nessa nova entrada, e insere também o contador numberOfKeys na nova árvore de goals do usuário e o inicializa com o valor 1.
        let goalKey = self.goalTextView.text!
        let name = goalKey
        let description = ""
        let firstStepDic : [String : String] = ["name": "", "description": ""]
        
        let goalKeyDict: [String : [String : Any]] = [goalKey: ["name": name, "description": description, "firstStep": firstStepDic]]
        let childUpdatesGoal = ["\(uid)": goalKeyDict]
        DAO.CST_GOALS_REF.updateChildValues(childUpdatesGoal)
        
        let numberOfKeysDict = ["numberOfKeys": 1]
        DAO.CST_GOALS_REF.child(uid).updateChildValues(numberOfKeysDict)
        
        numberCompleted += 1
        completionHandlerUsers(numberCompleted)
        
        // cria nova entrada na CST_STEPS com uid do usuário. insere step novo (vazio) nessa nova entrada, e insere também o contador numberOfKeys na nova árvore de steps do usuário e o inicializa com o valor 1.
        let firstStepDict = [[], ["description": "", "isLastStep": true, "name": ""]] as [Any]
        let stepKeyDict = [goalKey: firstStepDict]
        let childUpdatesStep = ["\(uid)": stepKeyDict]
        DAO.CST_STEPS_REF.updateChildValues(childUpdatesStep)
        DAO.CST_STEPS_REF.child(uid).updateChildValues(numberOfKeysDict)
        
        numberCompleted += 1
        completionHandlerUsers(numberCompleted)
        
        // pega o valor de numberOfKeys em CST_GOALS e o atualiza com +1
        let handleCST_GOALS = DAO.CST_GOALS_REF.observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                print("to no numberOfKeys-USERS WITH CST GOALS")
                
                let key = String(snapshot.key)
                var keyNumber : Int = snapshot.value as! Int
                print("keyNumber ANTES = \(keyNumber)")
                keyNumber += 1
                print("keyNumber DEPOIS = \(keyNumber)")

                let childUpdatesGoal = ["\(String(describing: key))" : keyNumber]
                DAO.CST_GOALS_REF.updateChildValues(childUpdatesGoal)
                
                numberCompleted += 1
                completionHandlerUsers(numberCompleted)
            }
        })
        
        // pega o valor de numberOfKeys em CST_STEPS e o atualiza com +1
        let handleCST_STEPS = DAO.CST_STEPS_REF.observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                //print("to no numberOfKeys-USERS WITH CST STEPS")
                
                let key = String(snapshot.key)
                var keyNumber : Int = snapshot.value as! Int
                //print("keyNumber ANTES = \(keyNumber)")
                keyNumber += 1
                //print("keyNumber DEPOIS = \(keyNumber)")
                
                let childUpdatesGoal = ["\(String(describing: key))" : keyNumber]
                DAO.CST_STEPS_REF.updateChildValues(childUpdatesGoal)
                
                numberCompleted += 1
                completionHandlerUsers(numberCompleted)
            }
        })
        
//        DAO.CST_GOALS_REF.removeObserver(withHandle: handleCST_GOALS)
//        DAO.CST_STEPS_REF.removeObserver(withHandle: handleCST_STEPS)
    }
    
    
    // usuário possui SIM goal já criado -- não precisa criar nova árvore para o usuário! -- atualiza árvore já existente com novo goal, atualiza numberOfKeys da árvore do usuário com +1
    func handleAsynchronousRequestForNewCstGoalWithExistingTree (completionHandlerUsers: @escaping (_ numberCompleted: Int) -> Void) {
        var numberCompleted = 0

        let uid = userID
        print("uid: \(uid)")
        
        // cria nova entrada na árvore de CstGoals do usuário com novo goal
        let goalKey = self.goalTextView.text!
        
        let name = goalKey
        let description = ""
        let firstStepDic : [String : String] = ["name": "", "description": ""]
        let goalKeyDict = [goalKey: ["name": name, "description": description, "firstStep": firstStepDic]]
        
        let childUpdatesGoal = goalKeyDict
        DAO.CST_GOALS_REF.child(uid).updateChildValues(childUpdatesGoal)
        
        numberCompleted += 1
        completionHandlerUsers(numberCompleted)
        
        // cria nova entrada na árvore de CstSteps do usuário com novo primeiro step referente ao novo Goal
        let firstStepAtCstStepDict = [[], ["description": "", "isLastStep": true, "name": ""]] as [Any]
        let stepKeyDict = [goalKey: firstStepAtCstStepDict]
        
        let childUpdatesStep = stepKeyDict
        DAO.CST_STEPS_REF.child(uid).updateChildValues(childUpdatesStep)
        
        numberCompleted += 1
        completionHandlerUsers(numberCompleted)
        
        // pega o valor de numberOfKeys na árvore de goals do usuário e o atualiza com +1
        let handleGoal = DAO.CST_GOALS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                print("to no numberOfKeys-CST GOALS DO CURRENT USER")
                
                let key = String(snapshot.key)
                var keyNumber : Int = snapshot.value as! Int
                print("keyNumber ANTES = \(keyNumber)")
                keyNumber += 1
                print("keyNumber DEPOIS = \(keyNumber)")
                
                let childUpdates = ["\(String(describing: key))" : keyNumber]
                DAO.CST_GOALS_REF.child(uid).updateChildValues(childUpdates)
                
                numberCompleted += 1
                completionHandlerUsers(numberCompleted)
            }
        })
        
        // pega o valor de numberOfKeys na árvore de steps do usuário e o atualiza com +1
        let handleStep = DAO.CST_STEPS_REF.child(uid).observe(.childAdded, with: { (snapshot) in
            
            if snapshot.key == "numberOfKeys" {
                print("to no numberOfKeys-CST GOALS DO CURRENT USER")
                
                let key = String(snapshot.key)
                var keyNumber : Int = snapshot.value as! Int
                print("keyNumber ANTES = \(keyNumber)")
                keyNumber += 1
                print("keyNumber DEPOIS = \(keyNumber)")
                
                let childUpdates = ["\(String(describing: key))" : keyNumber]
                DAO.CST_STEPS_REF.child(uid).updateChildValues(childUpdates)
                
                numberCompleted += 1
                completionHandlerUsers(numberCompleted)
            }
        })
        
//        DAO.CST_GOALS_REF.removeObserver(withHandle: handle)
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
}
