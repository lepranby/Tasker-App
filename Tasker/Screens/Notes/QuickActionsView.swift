//
//  QuickActionsView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 25.07.23.
//

import SwiftUI

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.cyan.opacity(0.9))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct DelButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.red.opacity(0.8))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 1.8 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct QuickActionsView: View {
    
    @StateObject private var vm = ViewModel()
    @EnvironmentObject var notes: Notes
    @State private var showingAlert = false
    
    var body: some View {
        // MARK: - Секция действий
        HStack {
            ScrollView (.horizontal) {
                HStack {
                    Button {
                        vm.toggleAll()
                    } label: {
                        Label("Снять все метки", systemImage: "heart.slash")
                    }
                    .buttonStyle(GrowingButton())
                    
                    Button {
                        showingAlert = true
                    } label: {
                        Label("Удалить все", systemImage: "trash")
                    }
                    .alert(isPresented:$showingAlert) {
                        Alert(
                            title: Text("Внимание!"),
                            message: Text("Вы уверенны, что хотите удалить все заметки? Выполняемые действия необратимы."),
                            primaryButton: .destructive(Text("Удалить")) {
                                cleaner()
                            },
                            secondaryButton: .cancel(Text("Отмена"))
                        )
                    }
                    .buttonStyle(DelButton())
                }
            }
            
        }
    }
    
    func cleaner () {
        notes.notes.removeAll()
    }
}

struct QuickActionsView_Previews: PreviewProvider {
    static var previews: some View {
        QuickActionsView()
            .environmentObject(Notes())
    }
}
