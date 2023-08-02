//  NotesData.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import Foundation
import SwiftUI

struct Note : Codable, Identifiable {
    var id = UUID().uuidString
    var title: String
    var content: String
    var timeStamp: String
}

@MainActor class Notes : ObservableObject {
    private let NOTES_KEY = "noteskey"
    let date = Date()
    var notes: [Note] {
        didSet {
            saveData()
            objectWillChange.send()
        }
    }
    
    /// Description:
    /// Грузим данные.
    /// Инициализируем в базе первоисточник информации как приветственную заметку.

    init() {
        if let data = UserDefaults.standard.data(forKey: NOTES_KEY) {
            if let decodedNotes = try? JSONDecoder().decode([Note].self, from: data) {
                notes = decodedNotes
                return
            }
        }
        notes = [Note(title: "Introducing.", content: "Привет! Это мой дипломный проект написанный на SwiftUI. Предлагаю потратить пару минут на знакомства с приложением. Enjoy! 👋🏼🤓", timeStamp: date.getFormattedDate(format: "HH:mm dd.MM.yyyy"))]
    }
    
    func addNote(title: String, content: String) {
        let tempNote = Note(title: title, content: content, timeStamp: date.getFormattedDate(format: "HH:mm dd.MM.yyyy"))
        notes.insert(tempNote, at: 0)
        saveData()
    }

    // MARK: - Записываем данные
    
    private func saveData() {
        if let encodedNotes = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encodedNotes, forKey: NOTES_KEY)
        }
    }
}

extension Date {
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

