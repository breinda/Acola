import UIKit

extension GoalsViewController: UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return goals.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = goalsCollectionView.dequeueReusableCellWithReuseIdentifier("goalCell", forIndexPath: indexPath) as! GoalCollectionViewCell
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal)
        cell.backgroundColor = UIColor.clearColor()
        
        cell.mountainImage.image = mountainArray[mountainArrayIndex]
        
        if mountainArrayIndex == 3 {
            mountainArrayIndex = 0
        }
        else {
            mountainArrayIndex += 1
        }
        
        return cell
    }
    
//    override func viewDidLayoutSubviews()
//    {
//        if let flowLayout = goalsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columnNum - 1)
//            let totalCellAvailableWidth = goalsCollectionView.frame.size.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right - spaceBetweenCells
//            cellWidth = floor(totalCellAvailableWidth / columnNum);
//        }
//    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
//        if let cell = GoalCollectionViewCell.fromNib() {
//            let cellMargins = cell.layoutMargins.left + cell.layoutMargins.right
//            //cell.configureWithIndexPath(indexPath)
//            cell.goalNameLabel.preferredMaxLayoutWidth = cellWidth - cellMargins
//            cell.labelWidthLayoutConstraint.constant = cellWidth - cellMargins //adjust the width to be correct for the number of columns
//            return cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize) //apply auto layout and retrieve the size of the cell
//        }
        
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 75)
    }
}