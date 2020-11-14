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
    var sectionAttributes = [UICollectionViewLayoutAttributes]()
    var cellLayout = [[UICollectionViewLayoutAttributes]]()
    override func prepare() {
        guard let collectionView = collectionView else {return}
        cell(collectionView: collectionView)
    }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellLayout[indexPath.section][indexPath.row]
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return sectionAttributes
    }
    func cell(collectionView:UICollectionView){
        var x = 0
        var y = 0
        var currentCol = 0
        for section in 0..<collectionView.numberOfSections{
            for index in 0..<colums{
                let indexPath = IndexPath(item: index, section: section)
                let layout = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                layout.frame = CGRect(x: x, y: y, width: width, height: height)
                //                print("x:\(x),y:\(y),colums:\(currentCol)")
                sectionAttributes.append(layout)
                x += width
                if x / width == colums {
                    currentCol += 1
                    x = 0
                    y += height
                }
            }
            cellLayout.append(sectionAttributes)
        }
   
    }
    
}

