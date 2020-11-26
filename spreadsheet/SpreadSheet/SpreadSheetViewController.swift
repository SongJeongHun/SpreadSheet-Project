import UIKit

class SpreadSheetViewController: UIViewController {
    let sheetModel = layoutModel()
    let cellManager = CellManage()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBAction func addCol(_ sender:Any){
        sheetModel.addNumOfSections(1)
        collectionView.reloadData()
    }
    @IBAction func addrow(_ sender:Any){
        //삭제 하고 다시그리기?
        //세로줄만 추가?
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension SpreadSheetViewController:UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if cellManager.selectedCell.contains(indexPath){
            return cellManager.inactiveCell(self.collectionView,indexPath)
        }else{
            return cellManager.activeCell(self.collectionView,indexPath)
        }
    }
}
extension SpreadSheetViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sheetModel.numOfSections//-> 행의 개수(row)
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
