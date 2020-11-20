//
//  SpreadSheetCollectionViewCell.swift
//  spreadsheet
//
//  Created by 송정훈 on 2020/11/14.
//
//● Frame
//정의 : SuperView(상위뷰)의 좌표시스템안에서 View의 위치와 크기를 나타냅니다.
//
//frame의 핵심. 바로 SuperView(상위뷰)입니다. 이때, 상위뷰라는 것은 한단계 상위뷰를 의미해요.
//ounds
//
//정의 : View의 위치와 크기를 자신만의 좌표시스템안에서 나타냅니다.
//
//bounds의 핵심. 바로 자신만의 좌표시스템을 쓴다는 것입니다.
import UIKit

class SpreadSheetLayout: UICollectionViewLayout {
    let colums = 8
    let width = 100
    let height = 25
    var contentSize: CGSize = .zero
    var sectionAttributes = [UICollectionViewLayoutAttributes]()
    var cellLayout = [[UICollectionViewLayoutAttributes]]()
    
    override func prepare() {
        guard let collectionView = collectionView else {return}
        if cellLayout.count != collectionView.numberOfSections {
            createCell(collectionView: collectionView)
            return
        }
        for section in 0..<collectionView.numberOfSections{
            for index in 0..<colums{
                let indexPath = IndexPath(item:index ,section: section)
                let layouts = layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: 0, height: 0))!
                let indexs = colums*section
               
                var frame = layouts[indexs].frame
                frame.origin.x = collectionView.contentOffset.x
                layouts[indexs].frame = frame
                layouts[indexs].zIndex = 100
                let layout = layoutAttributesForItem(at: indexPath)!
            
                if section == 0{
                    var frame = layout.frame
                    frame.origin.y = collectionView.contentOffset.y
                    layout.frame = frame
                    layout.zIndex = 100
                }
            }
        }
    }
    override var collectionViewContentSize: CGSize {
        return contentSize
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellLayout[indexPath.section][indexPath.row]
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return sectionAttributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        true
    }
    private func createCell(collectionView:UICollectionView){
        var x = 0
        var y = 0
        var contentwidth:CGFloat = 0
        var currentCol = 0
        for section in 0..<collectionView.numberOfSections{
            for index in 0..<colums{
                let indexPath = IndexPath(item: index, section: section)
                let layout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layout.frame = CGRect(x: x, y: y, width: width, height: height)
                sectionAttributes.append(layout)
                x += width
                if x / width == colums {
                    contentwidth = CGFloat(x)
                    currentCol += 1
                    x = 0
                    y += height
                }
            }
            cellLayout.append(sectionAttributes)
        }
        if let layout = cellLayout.last?.last {
            contentSize = CGSize(width: contentwidth, height: layout.frame.maxY)
        }
    }
}

