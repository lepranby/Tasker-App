//  CustomSearchBar.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct CustomSearchBar: View {
    
    @State var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField("Поиск", text: $searchText)
        }
        .padding(EdgeInsets(top: 10, leading: 8, bottom: 10, trailing: 8))
        .font(.callout)
        .fontWeight(.light)
        .background(.gray.opacity(0.1))
        .foregroundColor(.black.opacity(0.8))
        .cornerRadius(16)
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar()
    }
}
