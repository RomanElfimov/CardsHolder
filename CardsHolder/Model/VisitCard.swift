//
//  VisitCard.swift
//  CardsHolder
//
//  Created by Роман Елфимов on 25.05.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import UIKit

//массив, где будут храниться карточки
var dataArray: [VisitCard] = []

//MARK: - VisitCard

//одна визитка
class VisitCard {
    
    //MARK: - Properties
    
    var id: Int
    var name: String
    var email: String
    var phone: String
    
    var imagePath: String {
        return pathForLibrary+("/\(id).jpg")
    }
    var image: UIImage? {
        //код, возвращает картинку по imagePath
        get {
            return UIImage(contentsOfFile: imagePath)
        }
        //напишем сохранение, когда ставим картинку
        set {
            if newValue == nil {
                //удалить картинку
                let _ = try?  FileManager.default.removeItem(atPath: imagePath)
            } else {
                //сохраняем
                let imageData = newValue?.jpegData(compressionQuality: 1)
                FileManager.default.createFile(atPath: imagePath, contents: imageData, attributes: nil)
            }
        }
    }
    
    //MARK: - Initializers
    
    init() {
        self.id = Model.getNextID()
        self.name = ""
        self.email = ""
        self.phone = ""
        
    }
    
    init(name: String, email: String, phone: String) {
        self.id = Model.getNextID()
        self.name = name
        self.email = email
        self.phone = phone
    }
    
    init(dictionary: NSDictionary) {
        self.id = dictionary.object(forKey: "mid") as! Int
        self.name = dictionary.object(forKey: "mname") as! String
        self.email = dictionary.object(forKey: "memail") as! String
        self.phone = dictionary.object(forKey: "mphone") as! String
        //self.imageName = dictionary.object(forKey: "mimageName") as! String
    }
    
    //MARK: - Method
    
    //формирует словарь NSDictionary
    func getDictionaryForSave() -> NSDictionary {
        let dict = NSDictionary(objects: [id, name, email, phone], forKeys: (["mid", "mname", "memail", "mphone"]) as [NSCopying])
        return dict
    }
}
