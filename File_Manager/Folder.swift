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
    var id = UUID()
    var folderName:String
    var parentFolder:Folder?
    @Relationship(deleteRule:.cascade) var childFolders:[Folder] = []
    var createDate:Date
    var location:String
    init(folderName: String, createDate: Date, location: String,parentFolder:Folder?) {
        self.folderName = folderName
        self.createDate = createDate
        self.location = location
        self.parentFolder = parentFolder
    }
}
