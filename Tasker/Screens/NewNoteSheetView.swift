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
                Section (header: Text("Заголовок")) {
                    TextField("", text: $title)
                        .submitLabel(.continue)
                }
                Section (header: Text("Текст заметки")){
                    TextEditor(text: $content)
                        .submitLabel(.done)
                        .font(.callout)
                        .fontWeight(.light)
                    VStack (alignment: .center) {
                        Text("Рекомендуемое количество символов: \(content.count)/120")
                            .font(.footnote)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
            .padding(.top, -5)
            .navigationTitle("Добавить запись")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar(content: {
                
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Отмена", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem {
                    NavigationLink {} label: {
                        Button {
                            if content.isEmpty {
                                let empty = "Нет описания."
                                notes.addNote(title: title, content: empty)
                                dismiss()
                            } else {
                                notes.addNote(title: title, content: content)
                                dismiss()
                            }
                        } label: {
                            Label("Сохранить", systemImage: "checkmark")
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
