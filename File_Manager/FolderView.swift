//
//  FolderView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI

struct FolderView: View {
    @State var searchText = ""
    @Binding var mockFolders:[String]
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
                        ForEach(mockFolders, id: \.self){folderName in
                            FolderCell(folderName: folderName)
                                
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
            
        }
        .onTapGesture{
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .alert("New Folder", isPresented: $showingAlert) {
            TextField("Name", text: $newFolderName)
            Button{
                if(newFolderName != ""){
                    mockFolders.append(newFolderName)
                }
            }label: {
                Text("Add")
            }
            } message: {
                Text("Enter new folder name")
            }
        .searchable(text: $searchText)
        .padding()
    }
}


