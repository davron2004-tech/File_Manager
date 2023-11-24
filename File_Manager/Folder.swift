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
    @Relationship(inverse:.none) var parentFolder:Folder?
    var files:[Data] = []
    var createDate:Date
    var modifyDate:Date
    var location:String
    init(folderName: String, createDate: Date, location: String,parentFolder:Folder?) {
        self.folderName = folderName
        self.createDate = createDate
        self.modifyDate = createDate
        self.location = location
        self.parentFolder = parentFolder
    }
}
