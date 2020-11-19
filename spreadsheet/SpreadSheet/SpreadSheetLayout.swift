//
//  SpreadSheetCollectionViewCell.swift
//  spreadsheet
//
//  Created by 송정훈 on 2020/11/14.
//
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
        createCell(collectionView: collectionView)
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
    func createCell(collectionView:UICollectionView){
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
