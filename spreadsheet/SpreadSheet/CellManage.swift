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
    @IBAction func cliked(sender: UIButton!){
        print("Cliked")
        
    }
    
    func activeCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        //셀활성화 --------> 나중에 여기에 connect 콜?
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            let button = UIButton(frame: CGRect(x: cell.frame.minX, y:  cell.frame.minY, width: 20, height: 20))
            button.center = CGPoint(x: button.center.x, y: button.center.y)
            button.setTitle("T", for: .normal)
            button.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), for: .normal)
            button.addTarget(collectionView, action: Selector("cliked:"),  for: .touchUpInside)
            collectionView.addSubview(button)
            active(cell,indexPath)
        }
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

