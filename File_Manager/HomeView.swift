//
//  ContentView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var files:[Folder]
    @State var searchText = ""
    @State var mockFolders:[String] = ["One","Two","Three","Four"]
    var body: some View{
        NavigationStack{
            FolderView(mockFolders: $mockFolders)
                .navigationTitle("Home")
        }
        .searchable(text: $searchText)
        
        
    }
}


#Preview {
    HomeView()
}
