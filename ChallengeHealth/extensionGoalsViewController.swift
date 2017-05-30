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
}
