//  HomeView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct HomeView: View {
    
    @StateObject var notes = Notes()
    
    var body: some View {
        NavigationView {
            VStack {
                NoteView()
                    .tint(CustomColor.like)
            }
        }
        .environmentObject(notes)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Notes())
    }
}
