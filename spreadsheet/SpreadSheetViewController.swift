
import UIKit

class SpreadSheetViewController: UIViewController {
    let colums = 8
    let width = 100
    let height = 25
    var contentSize: CGSize = .zero
    let cellManager = cellManage()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var scollView:UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.isScrollEnabled = true
        initSize()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func initSize(){
        contentSize = CGSize(width:width * colums , height: height * collectionView.numberOfSections)
        for i in collectionView.constraints{
            if i.identifier == "height"{
                i.constant = contentSize.height
            }
        }
        collectionView.contentSize = contentSize
        scollView.contentSize = contentSize
    }
}
extension SpreadSheetViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellManager.activeCell(self.collectionView,indexPath)
    }
}
extension SpreadSheetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 100 + 1//-> 행의 개수(row)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colums    //-> 열의 개수(A~G)(col)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellManager.cellForItem(self.collectionView,indexPath)
    }
    
}
class spreadSheetCell:UICollectionViewCell{
    @IBOutlet weak var test:UILabel!
    //    @IBOutlet weak var text:UITextField!
    
}
class cellManage{
    var selectedCell = UICollectionViewCell()
    func activeCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
                collectionView.performBatchUpdates({
                cell.backgroundColor = #colorLiteral(red: 0.9832558036, green: 0.7072585225, blue: 0.7842617035, alpha: 1)
                cell.layer.borderColor = #colorLiteral(red: 0.6856962442, green: 0.03890464455, blue: 0.2881740928, alpha: 1)
                cell.layer.borderWidth = 2
                }, completion: {_ in self.selectedCell = cell})
        }
        let row = indexPath.section
        let int:UInt8 = 64 + UInt8(indexPath.row)
        var string = ""
        string.append(Character(UnicodeScalar(int)))
        print(" \(row) 행 \(string) 열")
    }
    func cellForItem(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spreadSheetCell", for: indexPath) as? spreadSheetCell else{ return UICollectionViewCell() }
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
