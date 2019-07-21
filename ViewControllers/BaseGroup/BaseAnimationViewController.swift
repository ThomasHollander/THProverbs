import UIKit
class BaseAnimationViewController: BaseViewController {
    var animateSubviews: [UIView] {
        return []
    }
    func hideSubviews(withAnimationDuration duration: TimeInterval, completion: @escaping ClosureVoid) {
        UIView.animate(withDuration: duration, animations: {
            self.animateSubviews.forEach { $0.alpha = 0.0 }
        }) { (_) in
            completion()
        }
    }
    func showSubviews(withAnimationDuration duration: TimeInterval, completion: @escaping ClosureVoid) {
        self.animateSubviews.forEach { $0.alpha = 0.0 }
        UIView.animate(withDuration: duration, animations: {
            self.animateSubviews.forEach { $0.alpha = 1.0 }
        }) { (_) in
            completion()
        }
    }
}
