import UIKit
import FirebaseAuth

class ObjetivosViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tarefasCollectionView: UICollectionView!
    var tarefas = [Tarefa]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tarefas.append(Tarefa(nome: "falar em sala", descricao: ""))
        
        tarefasCollectionView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        // MOSTRA A TELA DE LOGIN, CASO O USUARIO NAO ESTEJA LOGADO
        if FIRAuth.auth()?.currentUser == nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("LoginVC")
            self.presentViewController(vc, animated: false, completion: nil)
        }

        print(tarefas[0].nome)
        
        tarefasCollectionView.backgroundColor = UIColor.clearColor()
        tarefasCollectionView.reloadData()
    }
    
    
    // MARK: UICollectionView
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("AQUI")
        return tarefas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = tarefasCollectionView.dequeueReusableCellWithReuseIdentifier("tarefaCell", forIndexPath: indexPath) as! TarefaCollectionViewCell
        let tarefa = tarefas[indexPath.row]
        
        cell.configureCell(tarefa)
        cell.backgroundColor = UIColor.clearColor()
        
        print(tarefa.nome)
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
            
            let cell = sender as! TarefaCollectionViewCell
            let indexPath = tarefasCollectionView?.indexPathForCell(cell)
            //let request = tarefas[indexPath!.item]
            //let chatViewController = segue.destinationViewController as! ObjetivoAtualViewController
        }
    }
    
}