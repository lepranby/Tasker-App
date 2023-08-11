//  NewNoteSheetView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct NewNoteSheetView: View {
    
    @State private var title = ""
    @State private var content = ""
    
    @EnvironmentObject var notes: Notes
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section (header: Text("Загаловак")) {
                    TextField("", text: $title)
                        .submitLabel(.continue)
                }
                Section {
                    TextEditor(text: $content)
                        .submitLabel(.done)
                        .font(.callout)
                        .fontWeight(.light)
                } header: { Text("Нататка") } footer: {
                    Text("Рэкамендуемая колькасць сімвалаў: \(content.count)/120")
                        .font(.footnote)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .padding(.top, 10)
                }
            }
            .padding(.top, -5)
            .navigationTitle("Дадаць запіс")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar(content: {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Адмена", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem {
                        NavigationLink {} label: {
                            Button {
                                if content.isEmpty {
                                    let empty = "Няма апісання."
                                    withAnimation (Animation.easeOut(duration: 15)) {
                                        notes.addNote(title: title, content: empty)
                                    }
                                    dismiss()
                                } else {
                                    withAnimation (Animation.easeIn(duration: 15)) {
                                        notes.addNote(title: title, content: content)
                                    }
                                    dismiss()
                                }
                            } label: {
                                Label("Захаваць", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                                .tint(.teal) }
                        }
                        .disabled(title.isEmpty)
                    
                }
            })
        }
    }
}

struct AddNew_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteSheetView()
            .environmentObject(Notes())
    }
}

