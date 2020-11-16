/*  -DTO-
 -시트 정보 :[Sheet]
 */

/*  -스택-
 -시트 검색?
 -리스트 구현
 -segueway 이어주기 navigationBar
 */
import UIKit

class SpreadListViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
extension SpreadListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpreadListCell" ,for:indexPath) as? SpreadListCell else { return UITableViewCell() }
       
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //옆으로 스와이프 해서 삭제
        if editingStyle == .delete {
            //삭제 구현
        } else if editingStyle == .insert {
        }
    }
}

class SpreadListCell:UITableViewCell{
    @IBOutlet weak var sheetName:UILabel!
    @IBOutlet weak var writer:UILabel!
    @IBOutlet weak var time:UILabel!
}
