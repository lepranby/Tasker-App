//  TabBar.swift
//  Tasker
//
//  Created by Aleksej Shapran on 30.06.23

import SwiftUI

struct TabBar: View {
    
    @StateObject private var security = SecurityData()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Нататкі", systemImage: "calendar.day.timeline.leading")
                }
            SettingsView()
                .tabItem {
                    Label("Налады", systemImage: "person.badge.key.fill")
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
        .fullScreenCover(isPresented: $security.isLocked, content: {
            LockedView()
                .environmentObject(security)
                .interactiveDismissDisabled()
        })
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
