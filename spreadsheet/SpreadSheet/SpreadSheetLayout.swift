//
//  SpreadSheetCollectionViewCell.swift
//  spreadsheet
//
//  Created by 송정훈 on 2020/11/14.
//
//● Frame
//정의 : SuperView(상위뷰)의 좌표시스템안에서 View의 위치와 크기를 나타냅니다.
//frame의 핵심. 바로 SuperView(상위뷰)입니다. 이때, 상위뷰라는 것은 한단계 상위뷰를 의미해요.
//● Bounds

//정의 : View의 위치와 크기를 자신만의 좌표시스템안에서 나타냅니다.
//bounds의 핵심. 바로 자신만의 좌표시스템을 쓴다는 것입니다.
import UIKit

class SpreadSheetLayout: UICollectionViewLayout {
    let sheetModel = layoutModel()
    override func prepare() {
        guard let collectionView = collectionView else {return}
        if sheetModel.layoutAttributes.count != collectionView.numberOfSections {
            sheetModel.createCell(collectionView: collectionView)
            return
        }
        let forElement = layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: 0, height: 0))!
        sheetModel.stickyHeader(at: collectionView,forElement: forElement)
    }
    override var collectionViewContentSize: CGSize {
        return sheetModel.contentSize
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return sheetModel.layoutAttributes[indexPath.section][indexPath.row]
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return sheetModel.sectionAttribute
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
}
class layoutModel{
    var contentSize:CGSize = .zero
    var numberOfSections = 100 + 1
    var sectionAttribute:[UICollectionViewLayoutAttributes] = []
    var layoutAttributes:[[UICollectionViewLayoutAttributes]] = []
    var cellStandard:layoutStandard = layoutStandard(colums: 8, width: 100, height: 25)
    func initLayout(colums: Int, width: Int, height: Int){
        cellStandard = layoutStandard(colums: colums, width: width, height: height)
    }
    func createCell(collectionView:UICollectionView){
        var x = 0
        var y = 0
        var contentwidth:CGFloat = 0
        for section in 0..<collectionView.numberOfSections{
            for index in 0..<cellStandard.colums{
                let indexPath = IndexPath(item: index, section: section)
                let layout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layout.frame = CGRect(x: x, y: y, width: cellStandard.width, height: cellStandard.height)
                sectionAttribute.append(layout)
                x += cellStandard.width
                if x / cellStandard.width == cellStandard.colums {
                    contentwidth = CGFloat(x)
                    x = 0
                    y += cellStandard.height
                }
            }
            layoutAttributes.append(sectionAttribute)
        }
        if let layout = layoutAttributes.last?.last {
            contentSize = CGSize(width: contentwidth, height: layout.frame.maxY)
        }
    }
    func stickyHeader(at collectionView:UICollectionView,forElement : [UICollectionViewLayoutAttributes]){
        for section in 0..<collectionView.numberOfSections{
            for index in 0..<cellStandard.colums{
                let layouts = forElement
                let indexs = cellStandard.colums*section
                var frame = layouts[indexs].frame
                frame.origin.x = collectionView.contentOffset.x
                layouts[indexs].frame = frame
                layouts[indexs].zIndex = 100
                let layout = layouts[index]
                if section == 0{
                    var frame = layout.frame
                    frame.origin.y = collectionView.contentOffset.y
                    layout.frame = frame
                    layout.zIndex = 100
                }
            }
        }
    }
}
struct layoutStandard{
    let colums:Int
    let width:Int
    let height:Int
    init(colums:Int,width:Int,height:Int){
        self.colums = colums
        self.width = width
        self.height = height
    }
}
