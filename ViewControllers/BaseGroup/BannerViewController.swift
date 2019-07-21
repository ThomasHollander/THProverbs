import UIKit

class BannerViewController: BaseViewController {
    @IBOutlet weak var bannerHolderView: UIView!
    var isBannerVisible: Bool {
        get {
            return !IAPController.shared.isPurchased
        }
    }
//    private var bannerView: GADBannerView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkAndUpdateBannerVisibility()
    }
    func showBannerHolder(_ show: Bool, animated: Bool, completion: ClosureVoid? = nil) {
        if self.bannerHolderView.alpha == (show ? 1.0 : 0.0) {
            completion?()
            return
        }
        let show = {
            self.bannerHolderView.alpha = show ? 1.0 : 0.0
        }
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                show()
            }, completion: { _ in
                completion?()
            })
        } else {
            show()
            completion?()
        }
    }
//    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
//        self.banner(show: true)
//    }
//    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
//        self.banner(show: false)
//    }
    override func setupViews() {
        super.setupViews()
        self.checkAndCreateBanner()
        self.checkAndUpdateBannerVisibility()
    }
    private func checkAndUpdateBannerVisibility(withAnimation animation: Bool = false) {
        self.showBannerHolder(!IAPController.shared.isPurchased, animated: animation)
    }
    private func checkAndCreateBanner() {
        if IAPController.shared.isPurchased { return }
//        self.bannerView = GADBannerView(adSize: kGADAdSizeBanner)
//        self.bannerView?.alpha = 0.0
//        self.bannerView?.rootViewController = self
//        self.bannerView?.delegate = self
//        self.bannerView?.translatesAutoresizingMaskIntoConstraints = false
//        self.bannerHolderView.addSubview(bannerView!)
//        view.addConstraints(
//            [NSLayoutConstraint(item: bannerView!,
//                                attribute: .bottom,
//                                relatedBy: .equal,
//                                toItem: bottomLayoutGuide,
//                                attribute: .top,
//                                multiplier: 1,
//                                constant: 0),
//             NSLayoutConstraint(item: bannerView!,
//                                attribute: .centerX,
//                                relatedBy: .equal,
//                                toItem: view,
//                                attribute: .centerX,
//                                multiplier: 1,
//                                constant: 0)
//            ])
//        if let id = self.getBannerID() {
//            self.bannerView?.adUnitID = id
//        }
//        self.bannerView?.load(GADRequest())
    }
    private func banner(show: Bool) {
//        if self.bannerView?.alpha == (show ? 1.0 : 0.0) {
//            return
//        }
//        UIView.animate(withDuration: 0.25) {
//            self.bannerView?.alpha = show ? 1.0 : 0.0
//        }
    }
    private func getBannerID() -> String? {
        #if DEBUG
        return "ca-app-pub-XXXX"
        #else
        if self is RandomProverbViewController {
            return "ca-app-pub-XXXX"
        } else if self is FavoritesProverbsViewController {
            return "ca-app-pub-XXXX"
        } else if self is ProverbViewController {
            return "ca-app-pub-XXXX"
        } else {
            return nil
        }
        #endif
    }
    override func addNotificationsObserver() {
        super.addNotificationsObserver()
        self.notificaionCenter.addObserver(self,
                                           selector: #selector(BannerViewController.didUpdatePurchases(_:)),
                                           name: NSNotification.Name(rawValue: IAPController.NotificationName.DidPurchase),
                                           object: nil)
    }
    @objc private func didUpdatePurchases(_ notification: NSNotification) {
        self.checkAndUpdateBannerVisibility(withAnimation: true)
    }
}
