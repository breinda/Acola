import UIKit
//import Firebase
//import FirebaseAuth

extension UserSettingsViewController: UITableViewDataSource, UITableViewDelegate {

    //MARK: UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userSettingsCell", for: indexPath) as! UserSettingsTableViewCell
        
        switch expandedIndexPath {
        case .some(let expandedIndexPath) where expandedIndexPath as IndexPath == indexPath:
            cell.showsDetails = true
        default:
            cell.showsDetails = false
        }

        
        return cell
    }
    
    //MARK: UITableView Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        switch expandedIndexPath {
        case .some(_) where expandedIndexPath == indexPath:
            expandedIndexPath = nil
        case .some(let expandedIndex) where expandedIndex as IndexPath != indexPath:
            expandedIndexPath = nil
            self.tableView(tableView, didSelectRowAt: indexPath)
        default:
            expandedIndexPath = indexPath
        }
    }
}
