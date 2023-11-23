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
    var title:String
    var parentFolder:Folder?
    @Query(filter: #Predicate<Folder>{
        folder in
        folder.parentFolder == nil
    }) var rootFolders:[Folder]
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
            GeometryReader{
                geo in
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 15){
                        ForEach(parentFolder?.folders ?? rootFolders, id: \.self){folder in
                            FolderCell(folder: folder, folderName: folder.folderName)
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
            .navigationTitle(title)
            
        }
        .onTapGesture{
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .alert("New Folder", isPresented: $showingAlert) {
            TextField("Name", text: $newFolderName)
            Button{
                if(newFolderName != ""){
                    
                    if let safeFolder = parentFolder{
                        let newFolder = Folder(folderName: newFolderName, createDate: Date(), location: "", parentFolder: safeFolder)
                        safeFolder.folders.append(newFolder)
                    }
                    else{
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
}


