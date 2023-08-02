//  NoteView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct NoteView: View {
    
    @StateObject private var vm = ViewModel()
    @EnvironmentObject var notes: Notes
    
    @State private var newNoteSheetIsShowing = false
    @State private var searchText = ""
    @State private var isFavorite = false
    @State private var showingAlert = false
    
    var body: some View {
        
        // MARK: - Фильтрую содержимое относительно состояния поиска
        
        var filteredNotes: [Note] { if searchText.isEmpty { return notes.notes } else { return notes.notes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }}}
        
        VStack {
            NavigationView {
                // MARK: - Секция ячеек
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
                                    // MARK: - контекстное меню при лонг тапе
                                        .contextMenu {
                                            ShareLink("Поделиться",
                                                item: note.content,
                                                preview: SharePreview("Поделиться \(note.title)")
                                            )
                                            Button {} label: { Label("Закрыть", systemImage: "xmark") }
                                        } preview: {
                                            VStack {
                                                Text(note.content)
                                                    .frame(width: 320)
                                                    .font(.subheadline)
                                                    .fontWeight(.light)
                                                    .padding()
                                            }
                                            .frame(width: 400, height: 450)
                                        }
                                    HStack {
                                        Text("Создана в \(note.timeStamp)")
                                            .foregroundColor(.black.opacity(0.6))
                                            .font(.caption2)
                                            .fontWeight(.regular)
                                        Spacer()
                                        
                                        
                                        
                                        // MARK: - Метка "Важное" (лайк)
                                        
                                        Image(systemName: vm.contains(note) ? "checkmark.circle" : "circle.dashed")
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
                                .listRowSeparatorTint(.black.opacity(0.18))
                                
                                // MARK: - Свайпы
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    ShareLink(
                                        item: note.content,
                                        preview: SharePreview("Поделиться \(note.title)")
                                    )
                                    .tint(.green)
                                    .labelStyle(.iconOnly)
                                    .frame(width: 20, height: 10, alignment: .center)
                                    Button {
                                        vm.toggleFav(item: note)
                                        let vibration = UIImpactFeedbackGenerator(style: .soft)
                                        vibration.impactOccurred()
                                    } label: {
                                        withAnimation (Animation.easeOut(duration: 5)) {
                                            Image(systemName: vm.contains(note) ? "xmark.circle" : "circle.dashed")
                                        }
                                    }
                                    .tint(.cyan)
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
                                Button { vm.toggleAll() } label: { Image (systemName: "xmark.circle") }
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
                .navigationTitle("Заметки")
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

#if DEBUG
struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
//        NoteView()
//            .environmentObject(Notes())
//                    .previewDevice(PreviewDevice(rawValue: "iPhone 12 Mini"))
//                    .previewDisplayName("iPhone 12 Mini")
    }
}
#endif
