//
//  FolderCell.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI

struct FolderCell: View {
    var folder:Folder
    @State var folderName:String
    @State var isEdit = false
    @FocusState var isFocus:Bool
    @State var showingAlert = false
    @State var showingInfo = false
    var delegate:FolderView
    var body: some View {
        NavigationLink{
            FolderView(parentFolder:folder)
        }label: {
            VStack{
                Image(systemName: "folder.fill")
                    .foregroundStyle(Color("FolderColor"))
                    .font(.system(size: 60))
                    .padding(.bottom,3)
                if(isEdit){
                    TextField("", text: $folderName)
                        .foregroundStyle(Color(.label))
                        .focused($isFocus)
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidBeginEditingNotification)) { obj in
                            if let textField = obj.object as? UITextField {
                                textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
                            }
                        }
                        .onSubmit {
                            if(folderName != ""){
                                isEdit = false
                                isFocus = false
                                folder.folderName = folderName
                                folder.modifyDate = Date()
                            }
                            else{
                                showingAlert = true
                            }
                        }
                        
                }
                else{
                    Text(folderName)
                        .foregroundStyle(Color(.label))
                }
            }
            .contextMenu{
                Button{
                    showingInfo = true
                }label: {
                    Label("Get Info", systemImage: "info.circle")
                }
                Button{
                    isEdit = true
                    isFocus = true
                }label: {
                    Label("Rename", systemImage: "pencil")
                }
                Button{
                    delegate.deleteFolder(folder: folder)
                }label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
        .padding()
        .alert("Folder name cannot be empty!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                folderName = "untitled folder"
            }
        }
        .sheet(isPresented: $showingInfo){
            InfoView(folder: folder)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
        
    }
}

