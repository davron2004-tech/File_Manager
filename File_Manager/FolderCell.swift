//
//  FolderCell.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI

struct FolderCell: View {
    @Environment(\.modelContext) var modelContext
    var folder:Folder
    @State var folderName:String
    @State var isEdit = false
    @FocusState var isFocus:Bool
    @State var showingAlert = false
    var body: some View {
        NavigationLink{
            FolderView(title: folderName, parentFolder:folder)
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
                    isEdit = true
                    isFocus = true
                }label: {
                    Label("Rename", systemImage: "pencil")
                }
                Button{
                    
                }label: {
                    Label("Delete", systemImage: "trash")
                }
            }
            
            
            
        }
        
        
        .alert("Folder name cannot be empty!", isPresented: $showingAlert) {
            Button("OK", role: .cancel) {
                folderName = "untitled folder"
            }
        }
        .onAppear{
            folderName = folder.folderName
        }
        
    }
}

