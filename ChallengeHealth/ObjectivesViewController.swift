import UIKit
import Firebase
import FirebaseAuth

class ObjectivesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tasksCollectionView: UICollectionView!
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks.append(Task(name: "falar em sala", description: ""))
        
        tasksCollectionView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
            self.presentViewController(nextVC, animated: false, completion: nil)
        }

        print(tasks[0].name)
        
        tasksCollectionView.backgroundColor = UIColor.clearColor()
        tasksCollectionView.reloadData()
    }
    
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = tasksCollectionView.dequeueReusableCellWithReuseIdentifier("taskCell", forIndexPath: indexPath) as! TasksCollectionViewCell
        let Task = tasks[indexPath.row]
        
        cell.configureCell(Task)
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
    
    // faz as células expandirem até os cantos da tela!
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 150)
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToCurrentObjective" {
            
            let cell = sender as! TasksCollectionViewCell
            //let indexPath = tasksCollectionView?.indexPathForCell(cell)
            //let request = tasks[indexPath!.item]
            //let chatViewController = segue.destinationViewController as! CurrentObjectiveViewController
        }
    }
    
}