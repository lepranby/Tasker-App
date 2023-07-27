//
//  ImportantViewExtension.swift
//  Tasker
//
//  Created by Aleksej Shapran on 18.07.23.
//

import Foundation
import SwiftUI

extension ImportantView {
    
    final class ViewModel: ObservableObject {
        
        @Published var items = [Note]()
        @Published var showImportants = false
        @Published var savedItems: Set<String>
        
        private var base = ImportantData()
        
        func filterItems (_ item: Note) -> Bool {
            savedItems.contains(item.id)
        }
        
        var filteredItems: [Note]  {
            if showImportants {
                return items.filter { savedItems.contains($0.id) }
            }
            return items
        }
        
        init() {
            self.savedItems = base.load()
        }
        
        func sortFavs() {
            withAnimation() {
                showImportants.toggle()
            }
        }
        
        func contains(_ item: Note) -> Bool {
            savedItems.contains(item.id)
        }
        
        // Toggle saved items
        func toggleFav(item: Note) {
            if contains(item) {
                savedItems.remove(item.id)
            } else {
                savedItems.insert(item.id)
            }
            base.save(items: savedItems)
        }
        
        func toggleAll() {
            savedItems.removeAll()
            base.save(items: savedItems)
        }
    }
}
