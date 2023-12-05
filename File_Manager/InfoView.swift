//
//  InfoView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 28/11/23.
//

import SwiftUI
import Foundation
struct InfoView: View {
    @Environment(\.dismiss)
    var dismiss
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
                    Text(String(sizeOfObject()))
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
    func sizeOfObject() -> Int {
            var size = 0

            // Add size of properties
            size += MemoryLayout.size(ofValue: folder.id)
            size += MemoryLayout.size(ofValue: folder.folderName)
            size += MemoryLayout.size(ofValue: folder.createDate)
            size += MemoryLayout.size(ofValue: folder.modifyDate)
            size += MemoryLayout.size(ofValue: folder.location)

            // Recursively add size of child folders
            for childFolder in folder.childFolders {
                size += MemoryLayout.size(ofValue: childFolder)
            }

            // Add size of files (assuming each file is a Data object)
            for file in folder.files {
                size += MemoryLayout.size(ofValue: file)
            }

            return size
        }
}

extension Date {
    func getFormattedDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"

        return dateFormatter.string(from: self)
    }
}
