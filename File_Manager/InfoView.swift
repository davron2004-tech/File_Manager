//
//  InfoView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 28/11/23.
//

import SwiftUI
import Foundation
struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    var folder:Folder
    var body: some View {
        NavigationStack{
            VStack{
                Image(systemName: "folder.fill")
                    .foregroundStyle(Color("FolderColor"))
                    .font(.system(size: 150))
                Text(folder.folderName)
                    .fontWeight(.bold)
                    .padding()
                Divider()
                HStack{
                    Text("Information")
                        .fontWeight(.bold)
                    Spacer()
                }
                Divider()
                HStack{
                    Text("Size")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(String(sizeof(folder)))
                }
                Divider()
                HStack{
                    Text("Created")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(folder.createDate.getFormattedDate())
                }
                Divider()
                HStack{
                    Text("Modify Date")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(folder.modifyDate.getFormattedDate())
                }
                Divider()
                HStack{
                    Text("Location")
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(folder.location)
                }
            }
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        dismiss()
                    }label: {
                        Text("Done")
                    }
                }
            }
            .navigationTitle("Info")
            .navigationBarTitleDisplayMode(.inline)
        }
        
        .padding(.horizontal)
    }
    func sizeof <T> (_ : T) -> Int
    {
        return (MemoryLayout<T>.size)
    }
}

extension Date {
    func getFormattedDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return dateFormatter.string(from: self)
    }
}
