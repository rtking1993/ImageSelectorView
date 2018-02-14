import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageSelectorCollectionView: ImageSelectorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageSelectorCollectionView.images = [UIImage(named: "image1")!,
                                              UIImage(named: "image2")!,
                                              UIImage(named: "image3")!]
        imageSelectorCollectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: ImageSelectorCollectionViewDelegate

extension ViewController: ImageSelectorViewDelegate {
    func imageSelectorCollectionViewDidSelectImage(_ imageSelectorCollectionView: ImageSelectorView, didSelect image: UIImage) {
        print("Image: \(image)")
    }
    
    func imageSelectorCollectionViewdidSelectAddImage(_ imageSelectorCollectionView: ImageSelectorView) {
        print("Add image")
    }
}

