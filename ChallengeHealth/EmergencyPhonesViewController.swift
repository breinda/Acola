import UIKit


// extensão que possibilita linhas adicionais em strings
extension String {
    init(sep:String, _ lines:String...){
        self = ""
        for (idx, item) in lines.enumerated() {
            self += "\(item)"
            if idx < lines.count-1 {
                self += sep
            }
        }
    }
    
    init(_ lines:String...){
        self = ""
        for (idx, item) in lines.enumerated() {
            self += "\(item)"
            if idx < lines.count-1 {
                self += "\n"
            }
        }
    }
}


class EmergencyPhonesViewController: ElasticModalViewController/*UIViewController*/, UICollectionViewDelegate, UICollectionViewDataSource {

   // @IBOutlet weak var boddi: BoddiView!
    
    @IBOutlet weak var phonesCollectionView: UICollectionView!
    
    let defaultName: String = "CENTRO DE VALORIZAÇÃO DA VIDA"
    let defaultDesc: String = "Apoio emocional 24 horas"
    let defaultNum: String = "disque 141"
    
    
    override func viewDidLoad() {
      //  boddi.addNormalCycleAnimation()
    }
    
    
    // MARK: Navigation
    
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        self.modalTransition.edge = .right
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Collection View

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2/*goals.count*/
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = phonesCollectionView.dequeueReusableCell(withReuseIdentifier: "phoneCell", for: indexPath) as! PhoneCollectionViewCell
        
        cell.nameLabel.text = String(defaultName, "", "")
        cell.descLabel.text = defaultDesc
        cell.numLabel.text = defaultNum
        
        return cell
    }
    
    // TO DO: generalizar pro numero que estiver em numLabel
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = phonesCollectionView.dequeueReusableCell(withReuseIdentifier: "phoneCell", for: indexPath) as! PhoneCollectionViewCell
        
        print("LIGANDO...........")
        
        // trimming numLabel string
        let auxStr = cell.numLabel.text!
        let strIndex = auxStr.index(auxStr.startIndex, offsetBy: 7)
        
        guard let number = URL(string: "tel://" + auxStr.substring(from: strIndex)) else { return }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
            print("FUNFE")
        } else {
            // Fallback on earlier versions
            print("iOS10 ta faltando aqui")
            if let url = URL(string: "tel://\(number)") {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    // cuida de o quanto a gente expande as células da collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: 112)
    }
}
