import UIKit

class SpreadSheetViewController: UIViewController {
    let cellManager = CellManage()
    @IBOutlet weak var collectionView:UICollectionView!
    @IBAction func addRow(_ sender:Any){
        let alert = UIAlertController(title: "알림", message: "행 추가", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        let ok = UIAlertAction(title: "확인", style: .default, handler: {ok in
            guard let valStr = alert.textFields?[0].text else { return }
            guard let value = Int(valStr) else { return }
            layoutModel.shared.addNumOfSections(value)
            self.collectionView.reloadData()
        })
        let cancel = UIAlertAction(title: "취소", style: .default, handler:nil)
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func addCol(_ sender:Any){
        layoutModel.shared.addColums(collectionView: collectionView)
        collectionView.reloadData()
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
        return layoutModel.shared.cellStandard.numOfSections//-> 행의 개수(row)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layoutModel.shared.cellStandard.colums    //-> 열의 개수(A~G)(col)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellManager.cellForItem(self.collectionView,indexPath)
    }
}
class spreadSheetCell:UICollectionViewCell{
    @IBOutlet weak var test:UILabel!
}
