import UIKit

// MARK: ImageSelectorViewDelegate

protocol ImageSelectorViewDelegate: class {
    func imageSelectorCollectionViewDidSelectImage(_ imageSelectorCollectionView: ImageSelectorView, didSelect image: UIImage)
    func imageSelectorCollectionViewdidSelectAddImage(_ imageSelectorCollectionView: ImageSelectorView)
}

// MARK: ImageSelectorView

class ImageSelectorView: UIView {
    
    // MARK: Delegate
    
    weak var delegate: ImageSelectorViewDelegate?

    // MARK: Outlets
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: Variables
    
    var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: Constants
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)

    // MARK: View Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(cellClass: ImageSelectorCell.self)
    }
    
    // MARK: Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: ImageSelectorView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

// MARK: UICollectionViewDataSource and UICollectionViewDelegate Methods

extension ImageSelectorView: UICollectionViewDataSource, UICollectionViewDelegate {
    @objc func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count + 1
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageSelectorCell = collectionView.dequeueReusableCell(for: indexPath)
        
        if indexPath.row < images.count {
            let image = images[indexPath.row]
            cell.configure(with: image)
        } else {
            cell.configure(with: nil)
        }
        
        return cell
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < images.count {
            let image = images[indexPath.row]
            delegate?.imageSelectorCollectionViewDidSelectImage(self, didSelect: image)
        } else {
            delegate?.imageSelectorCollectionViewdidSelectAddImage(self)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ImageSelectorView: UICollectionViewDelegateFlowLayout {
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = (sectionInsets.top + sectionInsets.bottom)
        let availableHeight = frame.height - paddingSpace
        return CGSize(width: availableHeight, height: availableHeight)
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    @objc func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2.0
    }
}
