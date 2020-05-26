//
//  GlobalProperties.swift
//  CardsHolder
//
//  Created by Роман Елфимов on 25.05.2020.
//  Copyright © 2020 Рома. All rights reserved.
//

import Foundation

//MARK: - Global Properties

//путь к библиотеке (папке)
var pathForLibrary: String {
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
    return path
}

//путь к файлу data.plist"
var pathForData: String {
    return pathForLibrary + "/data.plist"
}
