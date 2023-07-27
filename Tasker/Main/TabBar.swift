//  TabBar.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct TabBar: View {
    
    @StateObject private var security = SecurityLock()
    @Environment(\.scenePhase) var scenePhase
    @State private var animate: Bool = false
    
    var body: some View {
        TabView {
                HomeView()
                    .tabItem {
                        Label("Заметки", systemImage: "calendar.day.timeline.leading")
                    }
                SettingsView()
                    .tabItem {
                        Label("Настройки", systemImage: "gear.badge.checkmark")
                    }
        }
        .accentColor(Color.black)
        .onAppear {
            
            // MARK: - FaceID
            
            security.showLockedViewIfEnabled()
            
            // MARK: - Макияж для таббара
            
            let appearance = UITabBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemChromeMaterialLight)
            appearance.shadowColor = .systemGray2
            
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
        
        // MARK: - Чекаем FaceID при входе на экран
        
        .onChange(of: scenePhase, perform: { value in
            switch value {
            case .background, .inactive:
                security.lockApp()
            default:
                break
            }
        })
        .sheet(isPresented: $security.isLocked) {
            LockedView()
                .environmentObject(security)
                .opacity(50)
                .interactiveDismissDisabled()
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
