import UIKit
import QuartzCore

class SegueFromRight: UIStoryboardSegue {
    
    override func perform() {
        let src : UIViewController = self.source
        //let dest: UIViewController = self.destinationViewController
        let transition : CATransition = CATransition()
        let timeFunc : CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        transition.duration = 0.25
        transition.timingFunction = timeFunc
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        src.view.layer.add(transition, forKey: kCATransition)
        //src.dismissViewControllerAnimated(true, completion: nil)
        //src.prepareForSegue(self, sender: src)
        //src.presentViewController(dest, animated: true, completion: nil)
    }
    
}
