//
//  Item.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import Foundation
import SwiftData

@Model
class Folder {
    var folderName:String
    var folders:[Folder] = []
    var files:[Data] = []
    var createDate:Date
    var modifyDate:Date
    var location:String
    init(folderName: String, createDate: Date, modifyDate: Date, location: String) {
        self.folderName = folderName
        self.createDate = createDate
        self.modifyDate = createDate
        self.location = location
    }
}
