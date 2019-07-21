import UIKit
class MenuViewController: BaseViewController, MenuListViewControllerDelegate {
    class var shared: MenuViewController {
        if let menu = UIApplication.shared.keyWindow?.rootViewController as? MenuViewController {
            return menu
        } else {
            return MenuViewController.create()!
        }
    }
    @IBOutlet private weak var container: UIView!
    var isMenuVisible: Bool {
        return self.sideViewController?.isVisible == true
    }
    var currentEmbeddedViewController: UIViewController? {
        return self.children.first
    }
    private var sideViewController: MenuListViewController?
    func show() {
        if self.isMenuVisible { return }
        guard let menu = MenuListViewController.create() else { return }
        menu.menuViewController = self
        self.sideViewController = menu
        menu.modalPresentationStyle = .overCurrentContext
        self.present(menu, animated: false, completion: nil)
    }
    func hide() {
        if !self.isMenuVisible { return }
        guard let menu = self.sideViewController else { return }
        menu.dismiss {
            self.sideViewController = nil
        }
    }
    func embed(viewController: UIViewController) {
        guard let oldViewControlelr = self.currentEmbeddedViewController else {
            return
        }
        oldViewControlelr.willMove(toParent: nil)
        oldViewControlelr.view.removeFromSuperview()
        oldViewControlelr.removeFromParent()
        self.addChild(viewController)
        viewController.view.frame = oldViewControlelr.view.frame
        self.container.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    func didSelect(button: UIButton, forItem item: MenuItem, onListViewController: MenuListViewController) {
        if !item.canBePerformed {
            switch item.unlockType {
            case .pay: self.showPurchaseAlert()
            case .payOrShare: self.showPurchaseOrUnlockAlert()
            default: break
            }
            return
        }
//        if item.type == .login {
//            self.checkAndSignInUser()
//            return
//        }
        guard let newViewController = item.viewController else {
            return
        }
        if isSame(viewController: newViewController) {
            self.hide()
            return
        }
        self.embed(viewController: newViewController)
        self.sideViewController?.dismiss(withCompletion: {
            self.sideViewController = nil
        })
    }
    private func isSame(viewController: UIViewController) -> Bool {
        guard let currentViewController = currentEmbeddedViewController else {
            return false
        }
        let currentType = type(of: currentViewController)
        let newType = type(of: viewController)
        return newType == currentType
    }
    private func checkAndSignInUser() {
        if UserManager.shared.isSignedIn {
            self.signOut()
        } else {
            self.signInUser()
        }
    }
    private func signInUser() {
        guard let menuViewController = self.sideViewController else {
            return
        }
        let signInCompletion = { (result: Bool) in
            menuViewController.checkAndUpdateLoginButtonTitle()
        }
        let actionSheet = ActionSheetViewController.makeWithTitle("Sign In with")
        let facebookAction = ActionSheetItem(type: .select, title: "Facebook", color: GlobalUI.Colors.facbookButton) { _ in
            UserManager.shared.signIn(onViewController: menuViewController, withOption: .facebook, completion: signInCompletion)
        }
//        let googleAction = ActionSheetItem(type: .select, title: "Google", color: GlobalUI.Colors.googleButton) { _ in
//            UserManager.shared.signIn(onViewController: menuViewController, withOption: .google, completion: signInCompletion)
//        }
        let cancelAction = ActionSheetItem(type: .destructive, title: "Cancel")
        actionSheet?.addItem(facebookAction)
//        actionSheet?.addItem(googleAction)
        actionSheet?.addItem(cancelAction)
        actionSheet?.present(onViewController: menuViewController)
    }
    private func showPurchaseAlert() {
        guard let listViewController = self.sideViewController else {
            return
        }
        self.showPurchaseAlert(onViewController: listViewController,
                               withMessage: "You can purchase or restore Full Access to enable all features and remove Ads.")
    }
    private func showPurchaseOrUnlockAlert() {
        guard let listViewController = self.sideViewController else {
            return
        }
        let daysLeftToUnlock = ShareToUnlock.shared.daysLeftToUnlock
        var message = "You can share Proverbs with your friends via Facebook or Twitter for \(daysLeftToUnlock) days to unlock it for free. Or you can purchase or restore Full Access."
        if daysLeftToUnlock == 1 {
            message = "You have to share Proverb one more time to unlock it for free."
        }
        self.showPurchaseAlert(onViewController: listViewController,
                               withMessage: message)
    }
    private func showPurchaseAlert(onViewController viewController: UIViewController, withMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let purchaseAction = UIAlertAction(title: "Purchase", style: .default, handler: { (action) in
            self.makePurchase()
        })
        let restoreAction = UIAlertAction(title: "Restore Purchases", style: .default, handler: { (action) in
            self.restorePurchases()
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
        })
        alert.addAction(purchaseAction)
        alert.addAction(restoreAction)
        alert.addAction(cancelAction)
        alert.preferredAction = purchaseAction
        viewController.present(alert, animated: true, completion: nil)
    }
    private func makePurchase() {
        guard let listViewController = self.sideViewController else {
            return
        }
        listViewController.activityIndicator(show: true, blockView: true)
        IAPController.shared.purchase { _ in
            listViewController.activityIndicator(show: false)
        }
    }
    private func restorePurchases() {
        guard let listViewController = self.sideViewController else {
            return
        }
        listViewController.activityIndicator(show: true, blockView: true)
        IAPController.shared.restore { _ in
            listViewController.activityIndicator(show: false)
        }
    }
    private func signOut() {
        UserManager.shared.signOut(withCompletion: { _ in
            self.sideViewController?.checkAndUpdateLoginButtonTitle()
        })
    }
}
