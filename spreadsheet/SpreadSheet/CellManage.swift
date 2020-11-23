//
//  CellManage.swift
//  spreadsheet
//
//  Created by 송정훈 on 2020/11/19.
//

import UIKit
class CellManage{
    var selectedCell:[IndexPath] = []
    //    var unSelectedCell:[UICollectionViewCell] = []
    func activeCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        //셀활성화 --------> 나중에 여기에 connect 콜?
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            print("\(indexPath.section),\(indexPath.row)")
            active(cell,indexPath)
        }
        let row = indexPath.section
        let int:UInt8 = 64 + UInt8(indexPath.item)
        var string = ""
        string.append(Character(UnicodeScalar(int)))
        print(" \(row) 행 \(string) 열")
        print("Selected Cell --------->\(selectedCell)")
        collectionView.reloadData()
    }
    func inactiveCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            inactive(cell,indexPath)
            print("Selected Cell --------->\(selectedCell)")
        }
    }
    func active(_ cell:UICollectionViewCell,_ indexPath:IndexPath){
        //열 전체 클릭, 행 전체 클릭
        if self.selectedCell != []{
            inactive(cell, self.selectedCell[0])
        }
        
        cell.backgroundColor = #colorLiteral(red: 0.7833575606, green: 0.9629107118, blue: 0.6487889886, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.09923628718, green: 0.3880366087, blue: 0.109238632, alpha: 1)
        cell.layer.borderWidth = 2
        self.selectedCell.append(indexPath)
       
        
    }
    func inactive(_ cell:UICollectionViewCell,_ indexPath:IndexPath){
        cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.borderWidth = 0.5
        if indexPath.section == 0{
            if indexPath.row == 0{
                //(0,0)
                cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }else{
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }else{
            if indexPath.row == 0{
                //1~xxx
                cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
        }
        self.selectedCell = selectedCell.filter({$0 != indexPath})
    }
    func cellForItem(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell{
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spreadSheetCell", for: indexPath) as? spreadSheetCell else{ return UICollectionViewCell() }
        cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        cell.layer.borderWidth = 0.5

        if indexPath.section == 0{
            if indexPath.row == 0{
                //(0,0)
                cell.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                cell.test.text = ""
            }else{
                //ABCD~
                let int:UInt8 = 64 + UInt8(indexPath.item)
                var string = ""
                string.append(Character(UnicodeScalar(int)))
                cell.test.text = string
                if selectedCell.contains(indexPath){
                    active(cell,indexPath)
                }else{
                    cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)                }
            }
        }else{
            if indexPath.row == 0{
                //1~xxx
                cell.test.text = String(indexPath.section)
                if selectedCell.contains(indexPath){
                    active(cell,indexPath)
                }else{
                    cell.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                }
            }else{
                //content
                cell.test.text = ""
                if selectedCell.contains(indexPath){
                    active(cell,indexPath)
                    
                }else{
                    inactive(cell,indexPath)
                }
            }
        }
        return cell
    }
}

