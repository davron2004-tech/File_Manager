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
    var parentFolder:Folder?
    var files:[Data] = []
    @Relationship(deleteRule:.cascade) var childFolders:[Folder] = []()
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
