//
//  GoalEditingViewController.swift
//  ChallengeHealth
//
//  Created by Brenda Carrocino on 26/07/17.
//  Copyright © 2017 Brenda Carrocino. All rights reserved.
//

import UIKit

class GoalEditingViewController: ElasticModalViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var stepsCollectionView: UICollectionView!
    
    @IBOutlet weak var bgRectangleImageView: UIImageView!
    @IBOutlet weak var backRectangleImageView: UIImageView!
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var boddiImageView: UIImageView!
    @IBOutlet weak var navBarRectangleImageView: UIImageView!
    @IBOutlet weak var goalRectangleImageView: UIImageView!
    
    @IBOutlet weak var goalTextView: UITextView!
    
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
        return 2/*steps.count*/
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = stepsCollectionView.dequeueReusableCell(withReuseIdentifier: "stepCell", for: indexPath) as! StepCollectionViewCell
        //let step = steps[(indexPath as NSIndexPath).row]
        
        cell.stepNumberLabel.text = "1"
        cell.stepNameLabel.text = "só no passinho"
        
        cell.backgroundColor = UIColor.clear
        cell.cellBackRectangleImageView.layer.borderWidth = 1
        cell.cellBackRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        
        return cell
    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 98)
    }
    
    
    
    // MARK: Navigation
    
    @IBAction func backButtonWasTapped(_ sender: AnyObject) {
        
        //        var transition = ElasticTransition()
        //        transition.edge = .left
        //        transition.radiusFactor = 0.3
        
        self.modalTransition.edge = .right
        
        self.dismiss(animated: true, completion: nil)
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
