/*  -DTO-
 -셀의 데이터:[[Any?]]
 -셀들의 속성:[[CellAttributes]] , 셀의 (이미지 or 텍스트 or URL) 타입:String ?
 -연결된 인원:[인원정보]
 -선택된 셀:[인원정보.이름:[선택된셀]]
 */

/*  -스택-
 -셀 선택, 셀 합치기
 -셀 병합?
 -셀 데이터 수정
 -행간 늘리기?
 -행,열 개수 늘리기
 -많은 데이터 불러오기
 -0행 0열 고정?
 -셀 레이아웃
 */
import UIKit

class SpreadSheetViewController: UIViewController {
    let colums = 8
    let width = 100
    let height = 25
    var contentSize: CGSize = .zero
    let cellManager = CellManage()
    @IBOutlet weak var collectionView:UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
extension SpreadSheetViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        if cellManager.selectedCell.contains(cell){
            return cellManager.inactiveCell(self.collectionView,indexPath)
        }else{
            return cellManager.activeCell(self.collectionView,indexPath)
        }
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
class CellManage{
    var selectedCell:[UICollectionViewCell] = []
    //    var unSelectedCell:[UICollectionViewCell] = []
    func activeCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        //셀활성화 --------> 나중에 여기에 connect 콜?
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            print("\(indexPath.section),\(indexPath.row)")
            collectionView.performBatchUpdates({
                //                self.unSelectedCell.append(cell)
                cell.backgroundColor = #colorLiteral(red: 0.7833575606, green: 0.9629107118, blue: 0.6487889886, alpha: 1)
                cell.layer.borderColor = #colorLiteral(red: 0.09923628718, green: 0.3880366087, blue: 0.109238632, alpha: 1)
                cell.layer.borderWidth = 2
                self.selectedCell.append(cell)
            }, completion: nil)
        }
        let row = indexPath.section
        let int:UInt8 = 64 + UInt8(indexPath.item)
        var string = ""
        string.append(Character(UnicodeScalar(int)))
        print(" \(row) 행 \(string) 열")
        print("Selected Cell --------->\(selectedCell)")
    }
    func inactiveCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            collectionView.performBatchUpdates({
                //                self.unSelectedCell.append(cell)
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                cell.layer.borderWidth = 0.5
                self.selectedCell = selectedCell.filter({$0 != cell})
            }, completion: nil)
            print("Selected Cell --------->\(selectedCell)")
        }
    }
    func cellForItem(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spreadSheetCell", for: indexPath) as? spreadSheetCell else{ return UICollectionViewCell() }
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.borderWidth = 0.5
        print(indexPath)
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                cell.test.text = ""
            }else{
                let int:UInt8 = 64 + UInt8(indexPath.item)
                var string = ""
                string.append(Character(UnicodeScalar(int)))
                cell.test.text = string
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }else{
            if indexPath.row == 0{
                cell.test.text = String(indexPath.section)
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }else{
                cell.test.text = ""
                
            }
        }
        return cell
    }
}


