import UIKit
//import Firebase
//import FirebaseAuth

extension UserSettingsViewController: UITableViewDataSource, UITableViewDelegate {

    //MARK: UITableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userSettingsCell", forIndexPath: indexPath) as! UserSettingsTableViewCell
        
        switch expandedIndexPath {
        case .Some(let expandedIndexPath) where expandedIndexPath == indexPath:
            cell.showsDetails = true
        default:
            cell.showsDetails = false
        }

        
        return cell
    }
    
    //MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        switch expandedIndexPath {
        case .Some(_) where expandedIndexPath == indexPath:
            expandedIndexPath = nil
        case .Some(let expandedIndex) where expandedIndex != indexPath:
            expandedIndexPath = nil
            self.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        default:
            expandedIndexPath = indexPath
        }
    }
}