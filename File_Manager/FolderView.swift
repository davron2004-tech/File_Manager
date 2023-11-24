//
//  FolderView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI
import SwiftData
struct FolderView: View {
    @Environment(\.modelContext) var modelContext
    @Query var allFolders:[Folder]
    var parentFolder:Folder?
    @State var searchText = ""
    @State var showingAlert = false
    @State var newFolderName:String = ""
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: columns,spacing: 15){
                    ForEach(allFolders.filter{folder in
                        if parentFolder != nil{
                            return folder.parentFolder == parentFolder
                        }
                        else{
                            return folder.parentFolder == nil
                        }
                    }, id: \.self){folder in
                        FolderCell(folder: folder, folderName: folder.folderName, folders: allFolders)
                    }
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showingAlert = true
                    }label: {
                        Image(systemName: "plus")
                    }
                    
                }
                
            }
            .navigationTitle(parentFolder?.folderName ?? "Home")
            
        }
        .onTapGesture{
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .alert("New Folder", isPresented: $showingAlert) {
            TextField("Name", text: $newFolderName)
            Button{
                if(newFolderName != ""){
                    if let safeFolder = parentFolder{
                        print(safeFolder.folderName)
                        let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: "", parentFolder: safeFolder)
                        modelContext.insert(newFolder)
                    }
                    else{
                        print(parentFolder?.folderName)
                        let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: "", parentFolder: nil)
                        modelContext.insert(newFolder)
                    }
                    newFolderName = ""
                }
            }label: {
                Text("Add")
            }
        } message: {
            Text("Enter new folder name")
        }
        .padding(.top)
        
    }
    func deleteFolder(folder:Folder){
        
    }
}


