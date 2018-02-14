import UIKit

class ImageSelectorCell: UICollectionViewCell, ReusableCell, NibLoadable, ConfigurableCell {
    
    // MARK: Outlets

    @IBOutlet var shadowView: UIView!
    @IBOutlet var imageView: UIImageView!
    
    // MARK: Variables
    
    var shapeLayer: CAShapeLayer?
    
    // MARK: Cell Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let layer = shapeLayer else {
            return
        }
        
        layer.path = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 16).cgPath
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        shapeLayer = nil
        imageView.image = nil
    }
    
    // MARK: Configure Methods
    
    func configure(with image: UIImage?) {
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = #imageLiteral(resourceName: "add")
            setupDottedLine()
        }
    }
    
    // MARK: Helper Method
    
    private func setupDottedLine() {
        shapeLayer = CAShapeLayer()
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.strokeColor = UIColor.darkGray.cgColor
        shapeLayer?.lineWidth = 6
        shapeLayer?.lineJoin = kCALineJoinRound
        shapeLayer?.lineDashPattern = [10, 10]
        shapeLayer?.path = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 16).cgPath
        imageView.layer.addSublayer(shapeLayer!)
        layoutIfNeeded()
    }
    
    private func setupShadow() {
        shadowView.layer.cornerRadius = 16
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
        shadowView.layer.shadowOpacity = 0.3
        shadowView.layer.shouldRasterize = true
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shadowRadius = 5
    }
}
