//
//  ImportantDetail.swift
//  Tasker
//
//  Created by Aleksej Shapran on 04.07.23.
//

import SwiftUI

struct ImportantDetail: View {
    @EnvironmentObject var noteVM: RecipeViewModel
    var category: Category
    
    var recipes: [Recipe] {
        return recipesVM.recipes.filter {$0.category == category.rawValue}
    }
    
    var body: some View {
        ScrollView {
            RecipeList(recipes: recipes)
        }
        .navigationTitle(category.rawValue)
    }
}

struct ImportantDetail_Previews: PreviewProvider {
    static var previews: some View {
        ImportantDetail(category: Category.soup)
            .environmentObject(RecipeViewModel())
    }
}

