//
//  NoteDetail.swift
//  Tasker
//
//  Created by Aleksej Shapran on 26.07.23.
//

import SwiftUI

struct NoteDetail : View {
    var title: String
    var content: String
    
    var body: some View {
        VStack {
            Form {
                Section {
                    Text(title)
                        .font(.title2)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                } header: {
                    Text ("Заголовок")
                }
                Section {
                    if content.isEmpty {
                        Text("Нет описания.")
                    } else {
                        Text(content)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .multilineTextAlignment(.leading)
                            .lineLimit(500)
                    }
                    } header: {
                        Text ("Текст заметки")
                    }
                    
                }
            }
            .navigationBarTitle(Text(title), displayMode: .inline)
    }
}

struct NoteDetail_Previews : PreviewProvider {
    static var previews: some View {
        NoteDetail(title: "Тестовый заголовок", content: "Тело заметки.")
    }
}
