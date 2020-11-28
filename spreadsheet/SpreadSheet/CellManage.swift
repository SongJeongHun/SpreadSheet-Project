//
//  CellManage.swift
//  spreadsheet
//
//  Created by 송정훈 on 2020/11/19.
//

import UIKit

class CellManage{
    var buttonTop:UIButton = UIButton()
    var buttonBottom:UIButton = UIButton()
    var selectedCell:[IndexPath] = []
    //    var unSelectedCell:[UICollectionViewCell] = []
    @IBAction func buttonMoved(_ sender:UIButton,forEvent:UIEvent){
        guard let touches = forEvent.touches(for: sender) else { return }
        drag(sender, touches: touches)
    }
    func drag(_ sender:UIButton,touches:Set<UITouch>){
        if let touch = touches.first{
            guard let collectionView = sender.superview as? UICollectionView else {return}
            let point = touch.location(in: sender.superview)
            let item = Int(floor(point.x)) / layoutModel.shared.cellStandard.width
            let section = Int(floor(point.y)) / layoutModel.shared.cellStandard.height
            let indexPath = IndexPath(item: item, section: section)
            guard !selectedCell.contains(indexPath) else {return}
            active(cellForItem(collectionView, indexPath), indexPath)
            collectionView.reloadData()
            print("Touch IndexPath-->[\(section),\(item)]")
        }
    }
    func addButton(view:UICollectionView){
        removeButton()
        let cell = cellForItem(view, selectedCell[0])
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "arrowshape.turn.up.backward.circle",withConfiguration: config)
        buttonTop = UIButton(frame: CGRect(x: cell.frame.minX-7, y:  cell.frame.minY-7, width: 15, height: 15))
        buttonBottom = UIButton(frame: CGRect(x: cell.frame.maxX-7, y:  cell.frame.maxY-7, width: 15, height: 15))
        buttonBottom.setImage(image, for: .normal)
        buttonBottom.addTarget(self, action: #selector(buttonMoved(_:forEvent:)) ,  for: .touchDragInside)
        buttonBottom.addTarget(self, action: #selector(buttonMoved(_:forEvent:)) ,  for: .touchDragOutside)
        buttonTop.setImage(image, for: .normal)
        buttonTop.addTarget(self, action: #selector(buttonMoved(_:forEvent:)) ,  for: .touchDragInside)
        buttonTop.addTarget(self, action: #selector(buttonMoved(_:forEvent:)) ,  for: .touchDragOutside)
        view.addSubview(buttonTop)
        view.addSubview(buttonBottom)
    }
    func removeButton(){
        buttonTop.removeFromSuperview()
        buttonBottom.removeFromSuperview()
    }
    func activeCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        //셀활성화 --------> 나중에 여기에 connect 콜?
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            selectedCell = []
            active(cell,indexPath)
            addButton(view: collectionView)
        }
        print("Selected Cell --------->\(selectedCell)")
        collectionView.reloadData()
    }
    func inactiveCell(_ collectionView: UICollectionView,_ indexPath: IndexPath){
        if let cell = collectionView.cellForItem(at: indexPath) as? spreadSheetCell{
            inactive(cell,indexPath)
            removeButton()
            print("Selected Cell --------->\(selectedCell)")
        }
    }
    func active(_ cell:UICollectionViewCell,_ indexPath:IndexPath){
        cell.backgroundColor = #colorLiteral(red: 0.7833575606, green: 0.9629107118, blue: 0.6487889886, alpha: 1)
        cell.layer.borderColor = #colorLiteral(red: 0.09923628718, green: 0.3880366087, blue: 0.109238632, alpha: 1)
        cell.layer.borderWidth = 2
        if !selectedCell.contains(indexPath){
            self.selectedCell.append(indexPath)
        }
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

