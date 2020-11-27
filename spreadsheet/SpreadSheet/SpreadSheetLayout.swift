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
    override func prepare() {
        guard let collectionView = collectionView else {return}
        if layoutModel.shared.layoutAttributes.count != collectionView.numberOfSections{
            layoutModel.shared.createCell(collectionView: collectionView)
            layoutModel.shared.setPointer(section: collectionView.numberOfSections, item: layoutModel.shared.cellStandard.colums)
            return
        }
        layoutModel.shared.stickyHeader(at: collectionView,forElement: layoutModel.shared.sectionAttribute)
    }
    override var collectionViewContentSize: CGSize {
        return layoutModel.shared.contentSize
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutModel.shared.sectionAttribute
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
}
class layoutModel{
    static let shared = layoutModel()
    private init(){
    }
    var numOfSections:Int = 100 + 1
    var contentSize:CGSize = .zero
    var pointerSection = 0
    var pointerItem = 0
    var sectionAttribute:[UICollectionViewLayoutAttributes] = []
    var layoutAttributes:[[UICollectionViewLayoutAttributes]] = []
    var cellStandard:layoutStandard = layoutStandard(colums: 8, width: 100, height: 25)
    func initLayout(colums: Int, width: Int, height: Int){
        cellStandard = layoutStandard(colums: colums, width: width, height: height)
    }
    func addNumOfSections(_ input:Int){
        self.numOfSections += input
    }
    func setPointer(section:Int,item:Int){
        self.pointerSection = section
        self.pointerItem = item
    }
    func addColums(collectionView:UICollectionView){
        cellStandard.colums += 1
        cellStandard.contentOffx = pointerItem * cellStandard.width
        cellStandard.contentOffy = 0
        var x = cellStandard.contentOffx
        var y = cellStandard.contentOffy
        for section in 0..<collectionView.numberOfSections{
            for item in pointerItem..<cellStandard.colums{
                let indexPath = IndexPath(item: item, section: section)
                let layout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layout.frame = CGRect(x: x, y: y, width: cellStandard.width, height: cellStandard.height)
                sectionAttribute.insert(layout, at: section * cellStandard.colums + item)
                layoutAttributes[section].append(layout)
                x += cellStandard.width
            }
            x = cellStandard.contentOffx
            y += cellStandard.height
        }
        if let layout = layoutAttributes.last?.last {
            contentSize = CGSize(width: CGFloat(cellStandard.width * cellStandard.colums), height: layout.frame.maxY)
        }
        pointerItem = cellStandard.colums
        cellStandard.contentOffx = 0
        cellStandard.contentOffy = y
    }
    func createCell(collectionView:UICollectionView){
        var attribute:[UICollectionViewLayoutAttributes]
        var x = cellStandard.contentOffx
        var y = cellStandard.contentOffy
        var contentwidth:CGFloat = 0
        for section in pointerSection..<collectionView.numberOfSections{
            attribute = []
            for index in 0..<cellStandard.colums{
                let indexPath = IndexPath(item: index, section: section)
                let layout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layout.frame = CGRect(x: x, y: y, width: cellStandard.width, height: cellStandard.height)
                sectionAttribute.append(layout)
                attribute.append(layout)
                x += cellStandard.width
                if x / cellStandard.width == cellStandard.colums {
                    contentwidth = CGFloat(x)
                    x = 0
                    y += cellStandard.height
                }
            }
            layoutAttributes.append(attribute)
            
        }
        if let layout = layoutAttributes.last?.last {
            contentSize = CGSize(width: contentwidth, height: layout.frame.maxY)
        }
        cellStandard.contentOffx = x
        cellStandard.contentOffy = y
    }
    
    func stickyHeader(at collectionView:UICollectionView,forElement : [UICollectionViewLayoutAttributes]){
        for section in 0..<collectionView.numberOfSections{
            for index in 0..<cellStandard.colums{
                let layouts = forElement
                let indexs = cellStandard.colums * section
                //0열 고정
                var frame = layouts[indexs].frame
                frame.origin.x = collectionView.contentOffset.x
                layouts[indexs].frame = frame
                layouts[indexs].zIndex = 100
                //0행 고정
                var layout = layouts[index]
                frame = layout.frame
                frame.origin.y = collectionView.contentOffset.y
                layout.frame = frame
                layout.zIndex = 100
                //(0,0)고정
                layout = layouts[0]
                frame = layout.frame
                frame.origin = CGPoint(x: collectionView.contentOffset.x,y: collectionView.contentOffset.y)
                layout.frame = frame
                layout.zIndex = 101
            }
        }
    }
}
struct layoutStandard{
    var colums:Int
    let width:Int
    let height:Int
    var contentOffx:Int = 0
    var contentOffy:Int = 0
    init(colums:Int,width:Int,height:Int){
        self.colums = colums
        self.width = width
        self.height = height
        self.contentOffy = 0
        self.contentOffx = 0
    }
}
