import UIKit

// função para aumentar o espaçamento entre os caracteres de um botão

extension UIButton {
    
    func addTextSpacing(spacing: CGFloat){
        
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: (self.titleLabel?.text!.characters.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
