//
//  ContentView.swift
//  File_Manager
//
//  Created by Davron Abdukhakimov on 22/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            FolderView(parentFolder:nil)
        }
        .padding()
    }
}


#Preview {
    HomeView()
}
