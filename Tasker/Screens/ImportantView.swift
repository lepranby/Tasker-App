//  ImportantView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct ImportantView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Вы еще не добавили ни одной задачи в избранное.")
            Spacer()
        }
        
    }
}

struct ImportantView_Previews: PreviewProvider {
    static var previews: some View {
        ImportantView()
    }
}
