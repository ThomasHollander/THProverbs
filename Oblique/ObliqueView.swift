import UIKit
class ObliqueView: UIView, ObliqueShape {
    var constructor: ObliqueConstructor?
    var isShadow = true {
        didSet {
            self.addShadow(isShadow)
        }
    }
    override var backgroundColor: UIColor? {
        set {
            self.obliqueColor = newValue ?? .white
        }
        get {
            return self.obliqueColor
        }
    }
    private var obliqueColor: UIColor = .white {
        didSet { self.setNeedsDisplay() }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        super.backgroundColor = UIColor.clear
        self.isShadow = true
        self.addShadow(self.isShadow)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.backgroundColor = UIColor.clear
        self.isShadow = true
        self.addShadow(self.isShadow)
    }
    private func addShadow(_ add: Bool) {
        self.layer.shadowColor      = add ? UIColor.black.withAlphaComponent(0.5).cgColor : nil
        self.layer.shadowOffset     = add ? CGSize(width: 2, height: 2) : CGSize(width: 0, height: 0)
        self.layer.shadowOpacity    = add ? 1.0 : 0.0
        self.layer.masksToBounds    = false
    }
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let constructor = self.constructor else { return }
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        constructor.addPathToContext(ctx, withRect: rect)
        ctx.setFillColor(self.obliqueColor.cgColor)
        ctx.fillPath()
    }
}
