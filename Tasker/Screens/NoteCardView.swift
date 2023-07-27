//
//  NoteListView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23.
//

import SwiftUI

struct NoteListView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NoteListView()
    }
}



//import SwiftUI
//
//struct RecipeList: View {
//    var recipes: [Recipe]
//    var body: some View {
//        VStack {
//                CustomSearchBar()
//                    .padding(EdgeInsets(top: 10, leading: -2, bottom: 10, trailing: 0))
//            HStack {
//                Text("Всего рецептов: \(recipes.count)")
//                    .font(.headline)
//                    .fontWeight(.light)
//                .opacity(0.8)
//                .padding(EdgeInsets(top: 0, leading: 3, bottom: -5, trailing: 0))
//                Spacer()
//            }
//            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140), spacing: 15)], spacing: 22) {
//                ForEach(recipes) { recipe in
//                    NavigationLink (destination: RecipeView(recipe: recipe)) {
//                        RecipeCard(recipe: recipe)
//                    }
//                    .accentColor(Color.black)
//                    .shadow(color: .gray, radius: 2)
//                }
//            }
//            .padding(.vertical)
//        }
//        .ignoresSafeArea(.keyboard)
//        .padding(.horizontal)
//
//    }
//}
//
//struct RecipeList_Previews: PreviewProvider {
//    static var previews: some View {
//        ScrollView {
//            RecipeList(recipes: Recipe.all)
//        }
//    }
//}
