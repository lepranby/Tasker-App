//  NoteView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct NoteView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var newNoteSheetIsShowing = false
    @State private var fullNoteViewIsShowing = false
    @EnvironmentObject var notes: Notes
    @State private var searchText = ""
    @State private var isFavorite = false
    @State private var showingAlert = false
    
    var body: some View {
        
        // MARK: - Поиск
        
        var filteredNotes: [Note] {
            if searchText.isEmpty {
                return notes.notes
            } else {
                return notes.notes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        // MARK: - Секция ячеек
        
        VStack {
            NavigationView {
                List {
                    if filteredNotes.isEmpty {
                        Section {
                            HStack {
                                Image(systemName: "doc.text.magnifyingglass")
                                    .resizable()
                                    .frame(width: 30, height: 34)
                                Spacer()
                                Text("У Вас нет сохраненных заметок. Добавьте заметку.")
                                    .font(.body)
                                    .fontWeight(.light)
                            }
                        } header: {
                            Text ("Заметки")
                        }
                    } else {
                        Section {
                            ForEach(filteredNotes) { note in
                                VStack(alignment: .leading) {
                                    Text(note.title)
                                        .font(.title2)
                                        .foregroundColor(CustomColor.titleTint)
                                        .fontWeight(.light)
                                        .padding(.bottom, -20)
                                    Text(note.content)
                                        .lineLimit(2)
                                        .lineSpacing(2)
                                        .font(.subheadline)
                                        .fontWeight(.light)
                                        .padding(.vertical)
                                        .padding(.bottom, -14)
                                    HStack {
                                        Text("Создана \(note.timeStamp)")
                                            .foregroundColor(.black.opacity(0.6))
                                            .font(.caption2)
                                            .fontWeight(.regular)
                                        Spacer()
                                        
                                        // MARK: - Подробный вид
                                        
                                        Image(systemName: "text.magnifyingglass")
                                            .foregroundColor(.black.opacity(0.6))
                                            .onTapGesture {
                                                withAnimation {
                                                    self.fullNoteViewIsShowing.toggle()
                                                }
                                            }
                                            
                                           
                                        // MARK: - лайк
                                        // Реакция на тап иконки и при свайпе лайка - легкая вибрация
                                        
                                        Image(systemName: vm.contains(note) ? "suit.heart.fill" : "suit.heart")
                                            .animation(.spring(response: 1.0, dampingFraction: 0.6))
                                            .foregroundColor(vm.contains(note) ? CustomColor.like : Color.black.opacity(0.6))
                                            .onTapGesture {
                                                isFavorite.toggle()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    isFavorite = false
                                                }
                                                vm.toggleFav(item: note)
                                                let vibration = UIImpactFeedbackGenerator(style: .soft)
                                                vibration.impactOccurred()
                                            }
                                    }
                                }
                                .listRowSeparatorTint(.black.opacity(0.2))
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        vm.toggleFav(item: note)
                                        let vibration = UIImpactFeedbackGenerator(style: .soft)
                                        vibration.impactOccurred()
                                    } label: {
                                        Label("", systemImage: "heart.fill")
                                    }
                                    .tint(.cyan)
                                    Button {
                                        withAnimation {
                                            self.fullNoteViewIsShowing.toggle()
                                        }
                                        let vibration = UIImpactFeedbackGenerator(style: .soft)
                                        vibration.impactOccurred()
                                    } label: {
                                        Label("", systemImage: "text.magnifyingglass")
                                    }
                                    .tint(.green)
                                }
                                .sheet(isPresented: $fullNoteViewIsShowing) {
                                    NavigationLink(destination: NoteDetail(title: note.title, content: note.content)) {
                                        VStack(alignment: .leading) {
                                            Text(note.title)
                                            Text(note.content)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                    
//                                    NoteDetail(title: note.title, content: note.content)
                                }
                            }
                            .onMove(perform: activateMove)
                            .onDelete(perform: deleteNote)
                        } header: {
                            Text ("Заметки")
                        }
                        
                        // MARK: - Секция действий
                        Section {
                            HStack {
                                Text ("Снять все метки")
                                    .fontWeight(.light)
                                Spacer ()
                                Button { vm.toggleAll() } label: { Image (systemName: "heart.slash") }
                                    .foregroundColor (.cyan)
                            }
                            .listRowBackground(LinearGradient(colors: [CustomColor.accentTint, .white, .white.opacity(0.8)], startPoint: .trailing, endPoint: .leading))
                            HStack {
                                Text ("Удалить все")
                                    .fontWeight(.light)
                                    .foregroundColor(.black)
                                Spacer ()
                                Button {
                                    showingAlert = true
                                } label: { Image (systemName: "trash") }
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
                                    .foregroundColor (.red)
                            }
                            .listRowBackground(LinearGradient(colors: [CustomColor.bin, .white.opacity(0.8), .white], startPoint: .trailing, endPoint: .leading))
                        } header: {
                            Text("Быстрые действия")
                        }
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button { withAnimation { self.newNoteSheetIsShowing.toggle() } } label: { Label("Добавить заметку", systemImage: "pencil.and.outline") }
                            .frame(width: 55, height: 35)
                            .tint(.black)
                    }
                }
                .navigationTitle("Заметки ")
                .navigationBarTitleDisplayMode(.automatic)
                .searchable(text: $searchText , prompt: "Поиск")
            }
        }
        .sheet(isPresented: $newNoteSheetIsShowing) {
            NewNoteSheetView()
        }
    }
    // MARK: - Функции
    
    func cleaner () {
        notes.notes.removeAll()
    }
    
    func deleteNote(at offsets: IndexSet) {
        notes.notes.remove(atOffsets: offsets)
    }
    
    // Двигаем ячейки по List'y
    
    func activateMove(from source: IndexSet, to destination: Int) {
        let vibration = UIImpactFeedbackGenerator(style: .medium)
        vibration.impactOccurred()
        notes.notes.move(fromOffsets: source, toOffset: destination)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
            .environmentObject(Notes())
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Mini"))
        //            .previewDisplayName("iPhone 12 Mini")
    }
}

