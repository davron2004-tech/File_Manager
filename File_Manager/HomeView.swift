//
//  ContentView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI

struct HomeView: View {
    @State var searchText = ""
    var body: some View {
        NavigationStack{
            FolderView(title: "Home", parentFolder:nil)
        }
        .padding()
    }
}


#Preview {
    HomeView()
}
