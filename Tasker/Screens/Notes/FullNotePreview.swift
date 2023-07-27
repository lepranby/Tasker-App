//
//  FullNotePreview.swift
//  Tasker
//
//  Created by Aleksej Shapran on 25.07.23.
//

import SwiftUI

struct FullNotePreview: View {
    
    
    @StateObject private var vm = ViewModel()
    @State private var newNoteSheetIsShowing = false
    @State private var fullNoteViewIsShowing = false
    @EnvironmentObject var notes: Notes
    @State private var searchText = ""
    @State private var isFavorite = false
    @State private var showingAlert = false
    
    var body: some View {

        var insetNote = Note
        
        VStack {
            Form {
                Section("Title:") {
                    Text(insetNote.title)
                }
                Section("Description:") {
                    Text(insetNote.content)
                }
            }
            
        }
    }
}

struct FullNotePreview_Previews: PreviewProvider {
    static var previews: some View {
        FullNotePreview()
            .environmentObject(Notes())
    }
}
