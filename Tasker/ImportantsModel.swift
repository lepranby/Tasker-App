//
//  ImportantsModel.swift
//  Tasker
//
//  Created by Aleksej Shapran on 04.07.23.
//

import Foundation

class ImportantsModel: ObservableObject {
    private var importantNotes: Set<String>
    
    private let saveKey = "Importants"
    
    init () {
        importantNotes = []
    }
    
    func contains (_ notes: Note) -> Bool {
        importantNotes.contains (Note.id)
    }
    
    func add(_ notes: Note) {
        objectwillChange.send ()
        importantNotes.insert (Note.id)
        save ()
    }
    
    func remove (_ notes: Note) {
        objectwillChange.send ()
        importantNotes.remove (Note.id)
        save()
    }
}
