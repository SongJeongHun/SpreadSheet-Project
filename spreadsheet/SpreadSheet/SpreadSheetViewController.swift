/*  -DTO-
 -셀의 데이터:[[Any?]]
 -셀들의 속성:[[CellAttributes]] , 셀의 (이미지 or 텍스트 or URL) 타입:String ?
 -연결된 인원:[인원정보]
 -선택된 셀:[인원정보.이름:[선택된셀]]
 */

/*  -기술-
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
    let sheetModel = layoutModel()
    let cellManager = CellManage()
    @IBOutlet weak var collectionView:UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
extension SpreadSheetViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)!
        if cellManager.selectedCell.contains(indexPath){
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
        return sheetModel.cellStandard.colums    //-> 열의 개수(A~G)(col)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellManager.cellForItem(self.collectionView,indexPath)
    }
}
class spreadSheetCell:UICollectionViewCell{
    @IBOutlet weak var test:UILabel!
}
