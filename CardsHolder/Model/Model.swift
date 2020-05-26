//
//  Model.swift
//  CardsHolder
//
//  Created by Рома on 22.01.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import Foundation

//MARK: - Model

class Model: NSObject {
    
    //MARK: - Class Methods
    
    class func loadData() {
        dataArray = []
        //загружаем файлы по пути PathForData
        let array = NSArray(contentsOfFile: pathForData)
        if let array = array {
            for dict in array {
                dataArray.append(VisitCard(dictionary: dict as! NSDictionary))
            }
        }
    }
    
    class func saveData() {
        var arrayForSave = NSArray()
        for visitCard in dataArray {
            arrayForSave = arrayForSave.adding(visitCard.getDictionaryForSave()) as NSArray
            //arrayForSave = arrayForSave.adding(visitCard.getDictionaryForSave()) as NSArray
        }
        arrayForSave.write(toFile: pathForData, atomically: true)
        //arrayForSave.write(toFile: pathForData, atomically: true)
    }
    
    class func getNextID() -> Int {
        var nextID = 0
        for visitCard in dataArray {
            if visitCard.id >= nextID {
                nextID = visitCard.id + 1
            }
        }
        return nextID
    }
    
}



