import UIKit
class XibView: UIView {
    fileprivate(set) var view: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    func commonInit() {
        self.xibSetup()
    }
    fileprivate func xibSetup() {
        guard let view = self.loadViewsFromNib() else {
            assert(false, "Failed to load view for signup alert")
            return
        }
        view.frame = self.bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        self.addSubview(view)
        self.view = view
    }
    fileprivate func loadViewsFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
}
