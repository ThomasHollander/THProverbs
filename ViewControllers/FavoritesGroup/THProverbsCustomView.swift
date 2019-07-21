//
//  
//

import Foundation
import UIKit

class THProverbsCustomView: UIView {
    var HomeBtn:UIButton!
    var RefreshBtn:UIButton!
    var LeftBtn:UIButton!
    var RightBtn:UIButton!
    var signoutBtn:UIButton!
    var ViewWidth:CGFloat = 250
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        HomeBtn = UIButton()
        self.addSubview(HomeBtn)
        RefreshBtn = UIButton()
        self.addSubview(RefreshBtn)
        LeftBtn = UIButton()
        self.addSubview(LeftBtn)
        RightBtn = UIButton()
        self.addSubview(RightBtn)
        signoutBtn = UIButton()
        self.addSubview(signoutBtn)
        ViewWidth = UIScreen.main.bounds.size.width/5
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        HomeBtn.frame = CGRect(x:(ViewWidth-44)/2, y:0, width:44, height:44)
        HomeBtn.setImage(UIImage.init(named: "icon-shouye"), for: .normal)
        RefreshBtn.frame = CGRect(x:ViewWidth+(ViewWidth-44)/2, y:0, width:44, height:44)
        RefreshBtn.setImage(UIImage.init(named: "icon-refresh"), for: .normal)
        LeftBtn.frame = CGRect(x:2*ViewWidth+(ViewWidth-44)/2, y:0, width:44, height:44)
        LeftBtn.setImage(UIImage.init(named: "icon-xiangzuo"), for: .normal)
        RightBtn.frame = CGRect(x:3*ViewWidth+(ViewWidth-44)/2, y:0, width:44, height:44)
        RightBtn.setImage(UIImage.init(named: "icon-xiangyou"), for: .normal)
        signoutBtn.frame = CGRect(x:4*ViewWidth+(ViewWidth-44)/2, y:0, width:44, height:44)
        signoutBtn.setImage(UIImage.init(named: "icon-tuichu"), for: .normal)
    }
    
    func setUp(model:NSObject) {
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
