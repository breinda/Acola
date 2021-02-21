import UIKit

// função para aumentar o espaçamento entre os caracteres de um botão

extension UIButton {
    
    func addTextSpacing(spacing: CGFloat){
        
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: spacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
