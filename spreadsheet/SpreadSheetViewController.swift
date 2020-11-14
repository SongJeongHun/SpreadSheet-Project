
import UIKit

class SpreadSheetViewController: UIViewController {
    let colums = 8
    let width = 100
    let height = 25
    var contentSize: CGSize = .zero
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var scollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isScrollEnabled = true
        contentSize = CGSize(width:width * colums , height: height * collectionView.numberOfSections)
        collectionView.contentSize = contentSize
        scollView.contentSize = contentSize
        print("scollView.contentSize---------->\(scollView.contentSize)")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("collectionView.contentSize---------->\(collectionView.contentSize)")
    }
}
extension SpreadSheetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100 //-> 행의 개수(row)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colums    //-> 열의 개수(A~G)(col)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spreadSheetCell", for: indexPath) as? spreadSheetCell else{ return UICollectionViewCell() }
        cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.borderWidth = 0.5
        let cellRow = indexPath.section
        let cellCol = indexPath.row
        if cellRow == 0{
            var int:UInt8 = 64 + UInt8(indexPath.row)
            var string = ""
            string.append(Character(UnicodeScalar(int)))
            cell.test.text = string
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        if cellCol == 0{
            cell.test.text = String(cellRow)
            cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
        if cellRow == 0 && cellCol == 0{
            cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            cell.test.text = ""
        }

        return cell
    }
    
}
class spreadSheetCell:UICollectionViewCell{
    @IBOutlet weak var test:UILabel!
//    @IBOutlet weak var touchButton:UIButton!
//    @IBOutlet weak var text:UITextField!
    
}

