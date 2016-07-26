import UIKit
import QuartzCore

class SegueFromRight: UIStoryboardSegue {
    
    override func perform() {
        let src: UIViewController = self.sourceViewController
        //let dest: UIViewController = self.destinationViewController
        let transition: CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        src.view.layer.addAnimation(transition, forKey: kCATransition)
        //src.dismissViewControllerAnimated(true, completion: nil)
        src.prepareForSegue(self, sender: src)
    }
    
}