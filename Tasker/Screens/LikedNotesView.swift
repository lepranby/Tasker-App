//  LikedNotesView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.07.23

import SwiftUI

struct LikedNotesView: View {
    
    @StateObject private var vm = LikedModel()
    @EnvironmentObject var notes: Notes
    
    @State private var newNoteSheetIsShowing = false
    @State private var searchText = ""
    @State private var isFavorite = false
    @State private var showingAlert = false
    
    var body: some View {

        List {
            Section {
                ForEach(vm.filteredItems) { note in
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
                }
            }
        }
        
        

    }
}

#if DEBUG
struct LikedNotesView_Previews: PreviewProvider {
    static var previews: some View {
        LikedNotesView()
            .environmentObject(Notes())
        //            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Mini"))
        //            .previewDisplayName("iPhone 12 Mini")
    }
}
#endif
