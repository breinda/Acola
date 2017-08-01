//
//  GoalEditingViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino ovar6/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit

class GoalEditingViewController: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    var stepsCollectionViewCenterY: CGFloat!
    
    @IBOutlet weak var bgRectangleImageView: UIImageView!
    @IBOutlet weak var backRectangleImageView: UIImageView!
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var boddiImageView: UIImageView!
    @IBOutlet weak var navBarRectangleImageView: UIImageView!
    @IBOutlet weak var goalRectangleImageView: UIImageView!
    
    @IBOutlet weak var goalTextView: UITextView!
    
    @IBOutlet weak var plusButton: UIButton!
    
    var steps = [Step]()
    var everyStepDict = [[], ["description": "", "isLastStep": true, "name": ""]] as [Any]
    var selectedCellIndex: Int = -1
    
    var placeholderStr: String = "nada aqui :)"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // popando a parte inútil
        print(everyStepDict.popLast()!)
        
        // setando espaçamento entre células como = 0
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        stepsCollectionView.collectionViewLayout = layout
        
        // setando propriedades das imagens
        bgRectangleImageView.layer.borderWidth = 1
        bgRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
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
        goalTextView.text = placeholderStr
        goalTextView.keyboardAppearance = .dark
        goalTextView.delegate = self
        hideKeyboardWhenTappedAround()
        
        // swipe down para acrescentar outra célula na collection view!
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        stepsCollectionView.addGestureRecognizer(swipeDown)
        swipeDown.delegate = self
        
        let panDown = UIPanGestureRecognizer(target: self, action: #selector(wasDragged(_:)))
        //paneDown.direction = UIPanGestureRecognizerDirection.down
        stepsCollectionView.addGestureRecognizer(panDown)
        stepsCollectionView.isUserInteractionEnabled = true
        panDown.delegate = self
        
        stepsCollectionViewCenterY = stepsCollectionView.center.y
        print("VIEWDIDLOAD -- stepsCollectionViewCenterY = \(stepsCollectionViewCenterY)")
        
        plusButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        steps.removeAll()
        
        handleAsynchronousRequestForSteps { numberCompleted, numberOfSteps in
            if numberCompleted == numberOfSteps {
                print("AEAEAEEA")
                print("number completed = \(numberCompleted)")
                
                self.stepsCollectionView.reloadData()
                
                DAO.CST_STEPS_REF.child(userID).child(self.placeholderStr).removeAllObservers()
            }
                
            else {
                print("OOPSIE ainda nao")
                print("number completed = \(numberCompleted)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goalTextView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        goalTextView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    
    // MARK: Collection View
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = stepsCollectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath) as! StepCollectionViewCell
        let step = steps[(indexPath as NSIndexPath).row]

        //print("ESTOU NA CELULA \(indexPath)")
        
        cell.configureCell(step)
        cell.backgroundColor = UIColor.clear
        cell.cellBackRectangleImageView.layer.borderWidth = 1
        cell.cellBackRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cell.stepNameTextField.delegate = self
        
        // recalcula o stepsCollectionViewCenterY quando recarregamos a collectionView
        stepsCollectionViewCenterY = stepsCollectionView.center.y
        
        //print("CELLFORITEMATINDEXPATH -- stepsCollectionViewCenterY = \(stepsCollectionViewCenterY)")
        
        return cell
    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 98)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        selectedCellIndex = indexPath.row
        print("INDEX SELECIONADO = \(selectedCellIndex)")
        
        //let cell = stepsCollectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath) as! StepCollectionViewCell
        
        stepUserInteraction = true
        stepsCollectionView.reloadData()
    }
    
    
    // MARK: Gesture Recognizers
    
    func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            //print(gestureRecognizer.view!.center.y)
            
            // se swipamos pra baixo
            if gestureRecognizer.view!.center.y > stepsCollectionViewCenterY {
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            }
            else { // se swipamos pra cima, NAO DEIXAR!
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: stepsCollectionViewCenterY + 1)
            }
            
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        // faz voltar pra posição inicial!
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: stepsCollectionViewCenterY)
            
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
    }
    
    func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
                let stepsCV = gesture.view! as! UICollectionView
                //print(type(of: stepsCV))
                
                if plusButton.isHidden {
                    stepsCollectionViewCenterY = stepsCollectionViewCenterY/*- 23*/ + plusButton.frame.height as CGFloat!
                    print("RESPOND TO SWIPE -- stepsCollectionViewCenterY = \(stepsCollectionViewCenterY)")
                    plusButton.isHidden = false
                }
                
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    // faz com que possamos reconhecer mais de um tipo de gesto ao mesmo tempo
    func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\nHELLO cabei de editar\n")
        
        // colocar aqui a salvação de step !!!!!!!!!
        
        print(textField.text!)
        
        stepUserInteraction = false
    }
    
    
    // MARK: Navigation
    
    @IBAction func plusButtonWasPressed(_ sender: Any) {
        
        print("steps[steps.count - 1] = \(String(describing: steps[steps.count - 1].index))")
        print("steps.count - 1 = \(steps.count - 1)")
        
        // apagando o que existe no array de steps e botar ali o conteúdo das células da collectionView
        let numOfCells = stepsCollectionView.numberOfItems(inSection: 0)
        steps.removeAll()
        var counter = 0
        var indexPath = NSIndexPath(row: counter, section: 0)
        
        var helperBool = false
        
        print("\nnumOfCells = \(numOfCells)")
        print(stepsCollectionView.numberOfItems(inSection: 0))
        
        while counter < numOfCells {
            
            print(counter)
            
//            self.view.layoutIfNeeded()
//            stepsCollectionView.layoutIfNeeded()
//            stepsCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
            
            
            while helperBool == false {
                if let cell = stepsCollectionView.cellForItem(at: indexPath as IndexPath) as! StepCollectionViewCell! {
                    print("ok")
                    helperBool = true
                }
                else {
                    print("whoops")
                    //stepsCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
                }
            }
            
            let cell = stepsCollectionView.cellForItem(at: indexPath as IndexPath) as! StepCollectionViewCell
            
            // se for o último step!
            if counter == numOfCells - 1 {
                steps.append(Step(name: cell.stepNameTextField!.text!, description: "", index: cell.stepNumberLabel!.text!, isLastStep: true))
            }
            else { // todos os outros casos
                steps.append(Step(name: cell.stepNameTextField!.text!, description: "", index: cell.stepNumberLabel!.text!, isLastStep: false))
            }

            counter += 1
            
            // scrollando collectionView pra última célula, pra que a mesma seja loadada e o cellForItem at indexPath não retorne nil
            // estamos fazendo isso no final do loop ao invés do início -- quando essa linha tava no início, aparentemente não dava tempo de scrollar e o cellForItem at indexPath ainda retornava nil...
            indexPath = NSIndexPath(row: counter, section: 0)
            if counter < numOfCells {
                stepsCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
                //sleep(1)
            }
            
            helperBool = false
        }
        
        // criando um step a mais
        steps[steps.count - 1].isLastStep = false
        steps.append(Step(name: "", description: "", index: String(Int(steps[steps.count - 1].index)! + 1), isLastStep: true))
        
        plusButton.isHidden = true
        
        // botando a collectionView de volta no lugar
        stepsCollectionView.frame.origin = CGPoint(x: stepsCollectionView.frame.origin.x, y: stepsCollectionView.frame.origin.y - plusButton.frame.height as CGFloat!)
        stepsCollectionView.reloadData()
    }
    
    // 0. salva o novo nome do goal no banco -- PROBLEMA: mudar o nome = mudar a key?
    // 1. armazena as infos das cells existentes (caso não vazias) no array de steps
    // 2. pega os steps do array de steps e os salva no banco
    @IBAction func saveButtonWasTapped(_ sender: Any) {
        print("")
        print("SAVE?")
        
        print("ANTES")
        for step in steps {
            print("step \(step.index!)")
            print("step name = \(step.name!)")
            print("isLastStep = \(step.isLastStep!)")
            print("")
        }
        
        // vamos apagar o que existe no array de steps e botar ali o conteúdo das células da collectionView
        print("NUMERO DE CELLS = \(stepsCollectionView.numberOfItems(inSection: 0))")
        let numOfCells = stepsCollectionView.numberOfItems(inSection: 0)
        steps.removeAll()
        var counter = 0
        var indexPath = NSIndexPath(row: counter, section: 0)
        
        while counter < numOfCells {
            
            let cell = stepsCollectionView.cellForItem(at: indexPath as IndexPath) as! StepCollectionViewCell

            // se for o último step!
            if counter == numOfCells - 1 {
                steps.append(Step(name: cell.stepNameTextField!.text!, description: "", index: cell.stepNumberLabel!.text!, isLastStep: true))
            }
            else { // todos os outros casos
                steps.append(Step(name: cell.stepNameTextField!.text!, description: "", index: cell.stepNumberLabel!.text!, isLastStep: false))
            }
            
            counter += 1
            
            indexPath = NSIndexPath(row: counter, section: 0)
            if counter < numOfCells {
                stepsCollectionView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
                
            }
            
        }
        
        print("DEPOIS, ANTES DE APAGAR O ULTIMO")
        for step in steps {
            print("step \(step.index!)")
            print("step name = \(step.name!)")
            print("isLastStep = \(step.isLastStep!)")
            print("")
        }
        
        // se o último step tiver nome = "", apagá-lo
        while steps.last?.name == "" {
            steps.popLast()
            steps[steps.count - 1].isLastStep = true
        }
        stepsCollectionView.reloadData()
        
        print("DEPOIS DE APAGAR O ULTIMO")
        for step in steps {
            print("step \(step.index!)")
            print("step name = \(step.name!)")
            print("isLastStep = \(step.isLastStep!)")
            print("")
        }
        
        // vamos criar um dicionário com os novos steps
        
        // primeiro, apagamos o que existia aqui
        everyStepDict.removeAll()
        // inicializamos o dict
        everyStepDict = [[], ["description": "", "isLastStep": true, "name": ""]] as [Any]
        // e tiramos esse lixo do final
        everyStepDict.popLast()
        
        print("")
        print("NOVOS STEPS:")
        for step in steps {
//            print("step \(step.index!)")
//            print("step name = \(step.name!)")
//            print("isLastStep = \(step.isLastStep!)")
//            print("")
            
            everyStepDict.append(["description": step.description!, "isLastStep": step.isLastStep!, "name": step.name!])
            
            // TODO: impedir de salvar goals com "buracos" nos steps (e.g. steps sem nome que nao sejam os ultimos)
            
            print(everyStepDict.last!)
        }
        
        let goalKey = placeholderStr
        // primeiro deletamos o que tava no goal
        DAO.CST_STEPS_REF.child(userID).child(goalKey).removeValue { erro, ref in
            if (erro != nil) {
                print("DELETE -- oops deu ruim!!!!")
            }
            else { // agora podemos atualizar o goal com os steps novos!
                let everyStepKeyDict = [goalKey: self.everyStepDict]
                //let childUpdatesStep = ["\(userID)": everyStepKeyDict]
                DAO.CST_STEPS_REF.child(userID).updateChildValues(everyStepKeyDict)
            }
        }
        DAO.CST_STEPS_REF.child(userID).removeAllObservers()
    }
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        
        //        var transition = ElasticTransition()
        //        transition.edge = .left
        //        transition.radiusFactor = 0.3
        
        //self.modalTransition.edge = .right
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Handlers for Asynchronous Stuff
    
    func handleAsynchronousRequestForSteps (completionHandlerStepSaved: @escaping (_ numberCompleted: Int, _ numberOfSteps: Int) -> Void) {
        
        var numberCompleted = 0
        var numberOfSteps = -1
        
        // botando todos os steps referentes ao goal atual no array de steps
        let uid = userID
        let goalKey = placeholderStr
        
        DAO.CST_STEPS_REF.child(uid).child(goalKey).observe(.childAdded, with: { (snapshotSteps) in
            
            self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))
            
            print("self.steps.last?.isLastStep! = \(self.steps[self.steps.count - 1].isLastStep!)")
            print("self.steps.last?.isLastStep! = \(String(describing: self.steps.last?.isLastStep!))")
            print("snapshotSteps.value = \(String(describing: snapshotSteps.value))")
            
            if (self.steps.last?.isLastStep!)! {
                print((self.steps.last?.index!)!)
                numberOfSteps = Int((self.steps.last?.index!)!)!
                print(numberOfSteps)
            }
            
            numberCompleted += 1
            completionHandlerStepSaved(numberCompleted, numberOfSteps)
        })
    }
    
//    // aplicar as alterações dos steps no banco !!
//    func handleAsynchronousRequestForChangingSteps (completionHandlerStepSaved: @escaping (Int) -> Void) {
//        
//        var numberCompleted = 0
//        
//        // vms botar todos os steps referentes ao goal atual no array de steps
//        let uid = userID
//        let goalKey = placeholderStr
//        
//        // primeiro temos que apagar a key deste goal :O
//        DAO.CST_STEPS_REF.child(uid).child(goalKey).removeValue()
//        
//        // e aí adicioná-la de novo, com os steps novos
//        // cria nova entrada na CST_STEPS com uid do usuário. insere step novo (vazio) nessa nova entrada, e insere também o contador numberOfKeys na nova árvore de steps do usuário e o inicializa com o valor 1.
//        let everyStepKeyDict = [goalKey: everyStepDict]
//        let childUpdatesStep = ["\(uid)": everyStepKeyDict]
//        DAO.CST_STEPS_REF.updateChildValues(childUpdatesStep)
//    }

    
    // MARK: Text View Properties
    
    // force the text in a UITextView to always center itself.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }

}
