import UIKit
import MessageUI

class AboutUsViewController: ElasticModalViewController/*UIViewController*/, UIScrollViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var aboutTextView: UITextView!
    @IBOutlet weak var backRectangleImageView: UIImageView!
    @IBOutlet weak var navBarRectangleImageView: UIImageView!
    
    override func viewDidLoad() {
        
        // setando propriedades das imagens
        backRectangleImageView.layer.borderWidth = 1
        backRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        
        navBarRectangleImageView.layer.borderWidth = 1
        navBarRectangleImageView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.12).cgColor
    }
    
    // faz com que a textView apareça scrollada a partir do início
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        aboutTextView.setContentOffset(CGPoint.zero, animated: false)
    }
    
    
    // MARK: Navigation
    
    @IBAction func returnButtonWasTapped(_ sender: AnyObject) {
        self.modalTransition.edge = .right
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: Email handling
    
    @IBAction func sendEmail(_ sender: Any) {
        
        let mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        
        mc.setSubject("[ACOLÁ] Olá!")
        
        let mensagemPadrao = "(bata um papo conosco! blablablá.......)"
        
        mc.setMessageBody(mensagemPadrao, isHTML: false)
        mc.setToRecipients(["brendac@live.it"])
        
        self.present(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            NSLog("Email Cancelado")
        case MFMailComposeResult.saved.rawValue:
            NSLog("Email Salvo")
        case MFMailComposeResult.sent.rawValue:
            NSLog("Email Enviado")
        case MFMailComposeResult.failed.rawValue:
            NSLog("Falha no Envio do Email")
        default: break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
