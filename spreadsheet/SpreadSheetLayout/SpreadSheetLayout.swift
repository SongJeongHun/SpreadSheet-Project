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
