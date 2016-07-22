import UIKit
import Firebase
import FirebaseAuth
import Firebase

class GoalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var goalsCollectionView: UICollectionView!
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // pega os goals do banco e os armazena no array goals
        DAO.STD_GOALS_REF.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            self.goals.append(Goal(key: snapshot.key, snapshot: snapshot.value as! Dictionary<String, AnyObject>))
            
//            print("goals.last.name")
//            print(self.goals.last?.name)
//            print("goals.last.description")
//            print(self.goals.last?.description)
//            print("goals.last.key")
//            print(self.goals.last?.key)
//            print("goals.last.firstStep.name")
//            print(self.goals.last?.firstStep.name)
//            print("goals.last.firstStep.index")
//            print(self.goals.last?.firstStep.index)
            
            self.goalsCollectionView.reloadData()
        })
        
        goalsCollectionView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
            self.presentViewController(vc, animated: false, completion: nil)
        }
        
        goalsCollectionView.backgroundColor = UIColor.clearColor()
        goalsCollectionView.reloadData()
    }
    
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return goals.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = goalsCollectionView.dequeueReusableCellWithReuseIdentifier("goalCell", forIndexPath: indexPath) as! GoalCollectionViewCell
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal)
        cell.backgroundColor = UIColor.clearColor()
        
        print(goal.name)

        return cell
    }
    
    // faz as células expandirem até os cantos da tela!
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 150)
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToCurrentStep" {
            
            let cell = sender as! GoalCollectionViewCell
            let indexPath = goalsCollectionView?.indexPathForCell(cell)
            let goal = goals[indexPath!.item]
            let currentStepVC = segue.destinationViewController as! CurrentStepViewController
            
            currentStepVC.goal = goal.name
            currentStepVC.step = goal.firstStep.name
            currentStepVC.goalKey = goal.key
        }
    }
    
}