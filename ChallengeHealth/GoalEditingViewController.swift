//
//  GoalEditingViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino ovar6/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit

class GoalEditingViewController: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate {
    
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
    
    var placeholder = "nada aqui :)"

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        goalTextView.text = placeholder
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
        
        //stepsCollectionViewCenterY = stepsCollectionView.center.y
        stepsCollectionViewCenterY = stepsCollectionView.frame.minY + 98 + 75 - 2
        print("stepsCollectionViewCenterY = \(stepsCollectionViewCenterY)")
        
        plusButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        steps.removeAll()
        
        handleAsynchronousRequest { numberCompleted in
            if numberCompleted == 1 {
                print("AEAEAEEA")
                print("number completed = \(numberCompleted)")
                
                self.stepsCollectionView.reloadData()
                
                DAO.CST_STEPS_REF.child(userID).child(self.placeholder).removeAllObservers()
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
        
        //cell.stepNumberLabel.text = "1"
        //cell.stepNameLabel.text = "só no passinho"
        
        cell.configureCell(step)
        cell.backgroundColor = UIColor.clear
        cell.cellBackRectangleImageView.layer.borderWidth = 1
        cell.cellBackRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        // recalcula o stepsCollectionViewCenterY quando recarregamos a collectionView
        stepsCollectionViewCenterY = stepsCollectionView.frame.minY + 98 + 75 - 2
        
        return cell
    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 98)
    }
    
    
    // MARK: Gesture Recognizers
    
    func wasDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began || gestureRecognizer.state == UIGestureRecognizerState.changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)
            
            // se swipamos pra baixo
            if (gestureRecognizer.view!.center.y > stepsCollectionViewCenterY) {
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
                print(type(of: stepsCV))
                
                if plusButton.isHidden {
                    stepsCollectionViewCenterY = stepsCollectionViewCenterY - 23 + plusButton.frame.height as CGFloat!
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
        print("BUBUBU")
        return true
    }
    
    
    @IBAction func plusButtonWasPressed(_ sender: Any) {
        
        print("steps[steps.count - 1] = \(String(describing: steps[steps.count - 1].index))")
        
        steps[steps.count - 1].isLastStep = false
        steps.append(Step(name: "", description: "", index: String(Int(steps[steps.count - 1].index)! + 1), isLastStep: true))
        
        plusButton.isHidden = true
        
        // botando a collectionView de volta no lugar
        stepsCollectionView.frame.origin = CGPoint(x: stepsCollectionView.frame.origin.x, y: stepsCollectionView.frame.origin.y - 1 - plusButton.frame.height as CGFloat!)
        stepsCollectionView.reloadData()
    }
    

    // MARK: Navigation
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        
        //        var transition = ElasticTransition()
        //        transition.edge = .left
        //        transition.radiusFactor = 0.3
        
        //self.modalTransition.edge = .right
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Handlers for Asynchronous Stuff
    
    func handleAsynchronousRequest (completionHandlerStepSaved: @escaping (Int) -> Void) {
        
        var numCompleted = 0
        
        // vamos botar todos os steps referentes ao goal atual no array de steps, pra gente nao ficar perdendo tempo procurando esse treco no banco toda hora
        let uid = userID
        let goalKey = placeholder
        
        DAO.CST_STEPS_REF.child(uid).child(goalKey).observe(.childAdded, with: { (snapshotSteps) in
            
            self.steps.append(Step(index: snapshotSteps.key, snapshot: snapshotSteps.value as! Dictionary<String, AnyObject>))
            
            numCompleted += 1
            completionHandlerStepSaved(numCompleted)
        })
    }

    
    // MARK: Text View Properties
    
    // force the text in a UITextView to always center itself.
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }

}
