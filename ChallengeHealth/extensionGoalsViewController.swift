import UIKit

extension GoalsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = goalsCollectionView.dequeueReusableCell(withReuseIdentifier: "goalCell", for: indexPath) as! GoalCollectionViewCell
        let goal = goals[(indexPath as NSIndexPath).row]
        
        cell.configureCell(goal)
        cell.backgroundColor = UIColor.clear
        
        // imagens das montanhas diferentes!!
        cell.mountainImage.image = mountainArray[mountainArrayIndex]
        
        if mountainArrayIndex == 3 {
            mountainArrayIndex = 0
        }
        else {
            mountainArrayIndex += 1
        }
        
        // swipe para delete? que por enquanto não faz nada e só printa
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        cell.addGestureRecognizer(swipeLeft)
        
        // tap para ir para CurrentStepVC
        let tap = UITapGestureRecognizer(target: self, action: #selector(respondToTapGesture(_:)))
        cell.addGestureRecognizer(tap)
        
        // long press para ir para GoalEditingVC
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(respondToLongPressGesture(_:)))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
//        if let cell = GoalCollectionViewCell.fromNib() {
//            let cellMargins = cell.layoutMargins.left + cell.layoutMargins.right
//            //cell.configureWithIndexPath(indexPath)
//            cell.goalNameLabel.preferredMaxLayoutWidth = cellWidth - cellMargins
//            cell.labelWidthLayoutConstraint.constant = cellWidth - cellMargins //adjust the width to be correct for the number of columns
//            return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize) //apply auto layout and retrieve the size of the cell
//        }
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 75)
    }
    
    
    // MARK: Gesture Recognizers
    
    @objc func respondToTapGesture(_ gesture: UIGestureRecognizer) {
        print("Tapped")
        let cell = gesture.view! as! GoalCollectionViewCell
        print(type(of: cell))
        let indexPath = goalsCollectionView?.indexPath(for: cell)
        let usableIndexPath = (indexPath! as NSIndexPath).item
        print("tapped at cell number \(usableIndexPath)")
        
        performSegue(withIdentifier: "goToCurrentStep", sender: cell)
    }
    
    @objc func respondToLongPressGesture(_ gesture: UIGestureRecognizer) {
        print("Long Pressed")
        let cell = gesture.view! as! GoalCollectionViewCell
        print(type(of: cell))
        let indexPath = goalsCollectionView?.indexPath(for: cell)
        let usableIndexPath = (indexPath! as NSIndexPath).item
        print("long pressed at cell number \(usableIndexPath)")
        
        // só podemos editar o goal se o mesmo for custom!
        if cell.isCustom {
            performSegue(withIdentifier: "goToGoalEditingFromGoals", sender: cell)
        }
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                print("Swiped right")
            case UISwipeGestureRecognizerDirection.down:
                print("Swiped down")
            case UISwipeGestureRecognizerDirection.left:
                print("Swiped left")
                let cell = gesture.view! as! GoalCollectionViewCell
                print(type(of: cell))
                
            case UISwipeGestureRecognizerDirection.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
}
