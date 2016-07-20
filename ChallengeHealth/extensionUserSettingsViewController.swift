import UIKit
//import Firebase
//import FirebaseAuth

extension UserSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK: UITableView Data Source
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userSettingsCell", forIndexPath: indexPath)
        
        return cell
    }
    
    //MARK: UITableView Delegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //cell will expand
    }
    
}