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
        
        return cell
    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // Code below
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width - 17, 75)
    }
}