//  LockedView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 17.07.23

import SwiftUI

// MARK: - Экран блокировки

struct LockedView: View {
    
    @EnvironmentObject var security: SecurityData
    
    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.clear, .cyan.opacity(0.6), .clear], startPoint: .top, endPoint: .bottom)
                .opacity(0.5)
                .blur(radius: 15)
            
            VStack {
                Spacer()
                HStack {
                    Text("Требуется FaceID")
                        .font(.title3)
                        .fontWeight(.light)
                }
                .padding(.horizontal, 112)
                .padding(.bottom, 15)
                Button("Разблокировать") { security.authenticate() }
                    .buttonStyle(CustomButton())
                    .padding(.bottom, 240)
            }
        }
        
    }
}

struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView()
    }
}
