
import UIKit

class SpreadSheetViewController: UIViewController {
    @IBOutlet weak var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
}
extension SpreadSheetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spreadSheetCell", for: indexPath) as? spreadSheetCell else{ return UICollectionViewCell() }
        cell.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.layer.borderWidth = 0.5
        cell.test.text = String(8 * indexPath.section + indexPath.row)
      
        return cell
    }
    
    
}
class spreadSheetCell:UICollectionViewCell{
    @IBOutlet weak var test:UILabel!
//    @IBOutlet weak var touchButton:UIButton!
//    @IBOutlet weak var text:UITextField!
    
}
//extension SpreadSheetViewController:UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width:CGFloat = collectionView.bounds.width / 10
//        let height:CGFloat = 25
//        return CGSize(width: width, height: height)
//    }
//}
