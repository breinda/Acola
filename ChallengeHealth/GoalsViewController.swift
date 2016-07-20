import UIKit
import FirebaseAuth

class GoalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var goalsCollectionView: UICollectionView!
    var goals = [Goal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goals.append(Goal(name: "falar em sala", description: ""))
        goals.append(Goal(name: "sair de casa", description: ""))
        
        goalsCollectionView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
            self.presentViewController(vc, animated: false, completion: nil)
        }

        print(goals[0].name)
        
        goalsCollectionView.backgroundColor = UIColor.clearColor()
        goalsCollectionView.reloadData()
    }
    
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("AQUI")
        return goals.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = goalsCollectionView.dequeueReusableCellWithReuseIdentifier("goalCell", forIndexPath: indexPath) as! GoalCollectionViewCell
        let goal = goals[indexPath.row]
        
        cell.configureCell(goal)
        cell.backgroundColor = UIColor.clearColor()
        
        print(goal.name)
        print("OIOIOI")
        
        return cell
    }
    
    // faz as células expandirem até os cantos da tela!
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        print("ENTAO NE........")
        return CGSizeMake(UIScreen.mainScreen().bounds.size.width, 150)
    }
    
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goToObjetivoAtual" {
            
            let cell = sender as! GoalCollectionViewCell
            let indexPath = goalsCollectionView?.indexPathForCell(cell)
            let goal = goals[indexPath!.item]
            let currentStepVC = segue.destinationViewController as! CurrentStepViewController
            
            currentStepVC.goal = goal.name
        }
    }
    
}