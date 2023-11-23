//
//  FolderCell.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI

struct FolderCell: View {
    @State var folderName:String
    @State var isEdit = false
    @FocusState var isFocus:Bool
    var body: some View {
        NavigationLink{
            
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
            }
            
        }
        
    }
}
#Preview {
    FolderCell(folderName: "Hello")
}
