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
    var contentsToShow:[Folder]{
        let contents = parentFolder?.childFolders ?? allFolders.filter{
            $0.parentFolder == nil
        }
        if searchText != ""{
            return contents.filter{
                $0.folderName.contains(searchText)
            }
        }
        else{
            return contents
        }
    }
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    TextField("Search", text: $searchText)
                    Spacer()
                    Button{
                        dismissKeyboard()
                    }label: {
                        Image(systemName: "magnifyingglass")
                    }
                }
                .foregroundStyle(.secondary)
                .padding(.all,8)
                .background(Color("SearchBarColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 15){
                        ForEach(contentsToShow){folder in
                            FolderCell(folder: folder, folderName: folder.folderName,delegate:self)
                        }
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
        .padding()
        .onTapGesture{
            dismissKeyboard()
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
    func dismissKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    func addFolder(){
        if(newFolderName != ""){
            if let safeFolder = parentFolder{
                var parents:[String] = []
                var tempParent = parentFolder
                while(tempParent != nil){
                    parents.append(tempParent!.folderName)
                    tempParent = tempParent?.parentFolder
                }
                parents = parents.reversed()
                var location = "~"
                for directory in parents{
                    location.append(" -> ")
                    location.append(directory)
                }
                let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: location, parentFolder: safeFolder)
                safeFolder.childFolders.append(newFolder)
                safeFolder.modifyDate = Date()
                try? modelContext.save()
            }
            else{
                let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: "~", parentFolder: nil)
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


