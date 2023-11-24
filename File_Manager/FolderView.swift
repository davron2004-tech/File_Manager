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
                    ForEach(parentFolder?.childFolders ?? allFolders.filter{
                        $0.parentFolder == nil
                    }, id: \.self){folder in
                        FolderCell(folder: folder, folderName: folder.folderName,delegate:self)
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
                addFolder()
            }label: {
                Text("Add")
            }
        } message: {
            Text("Enter new folder name")
        }
        .padding(.top)
        
    }
    func addFolder(){
        if(newFolderName != ""){
            if let safeFolder = parentFolder{
                let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: "", parentFolder: safeFolder)
                safeFolder.childFolders.append(newFolder)
                try? modelContext.save()
            }
            else{
                let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: "", parentFolder: nil)
                modelContext.insert(newFolder)
            }
            newFolderName = ""
        }
    }
    func deleteFolder(folder:Folder){
        var order = 0
        if let safeFolder = parentFolder{
            for folder1 in safeFolder.childFolders{
                if folder.folderName == folder1.folderName{
                    parentFolder!.childFolders.remove(at: order)
                    try? modelContext.save()
                }
                else{
                    order += 1
                }
            }
        }
        else{
            for folder1 in allFolders{
                if folder.folderName == folder1.folderName{
                    modelContext.delete(folder)
                }
                else{
                    order += 1
                }
            }
        }
    }
}


