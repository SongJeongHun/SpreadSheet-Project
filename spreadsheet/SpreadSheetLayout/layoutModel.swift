//
//  layoutModel.swift
//  spreadsheet
//
//  Created by 송정훈 on 2020/11/27.
//

import UIKit
class layoutModel{
    static let shared = layoutModel()
    private init(){}
    
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
        self.cellStandard.numOfSections += input
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
    var numOfSections:Int = 100 + 1
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
