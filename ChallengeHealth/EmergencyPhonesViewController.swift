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
    
    //@IBOutlet weak var boddiLabel: UITextView!
    
    @IBOutlet weak var backRectangleImageView: UIImageView!
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var boddiImageView: UIImageView!
    @IBOutlet weak var navBarRectangleImageView: UIImageView!
    
    let defaultName: String = "CENTRO DE VALORIZAÇÃO DA VIDA"
    let defaultDesc: String = "Apoio emocional 24 horas"
    let defaultNum: String = "disque 141"
    
    
    override func viewDidLoad() {
      //  boddi.addNormalCycleAnimation()
        
        backRectangleImageView.layer.cornerRadius = 39
        backRectangleImageView.layer.borderWidth = 1
        backRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        
        navBarRectangleImageView.layer.borderWidth = 1
        navBarRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
        
        bubbleImageView.layer.cornerRadius = 26
        bubbleImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        bubbleImageView.layer.shadowOpacity = 0.1
        bubbleImageView.layer.shadowRadius = 4
        bubbleImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bubbleImageView.layer.shouldRasterize = true
        
        boddiImageView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        boddiImageView.layer.shadowOpacity = 0.1
        boddiImageView.layer.shadowRadius = 4
        boddiImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        boddiImageView.layer.shouldRasterize = true
        
        //boddiLabel.delegate = self
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
