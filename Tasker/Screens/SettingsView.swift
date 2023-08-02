//  SettingsView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 13.07.23

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var security = SecurityData()
    @Environment(\.scenePhase) var scenePhase
    
    // MARK: - свитчер на FaceID
    
    var content: some View {
        Toggle("Использовать FaceID", isOn: $security.isAppLockEnabled)
            .fontWeight(.light)
            .onChange(of: security.isAppLockEnabled, perform: { value in
                security.appLockStateChange(value)
            })
            .tint(.cyan)
            .sheet(isPresented: $security.isLocked) {
                LockedView()
                    .environmentObject(security)
                    .interactiveDismissDisabled()
            }
    }
    
    // MARK: - Главная вью
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    HStack {
                        content
                            .onAppear {
                                security.showLockedViewIfEnabled()
                            }
                            .onChange(of: scenePhase, perform: { value in
                                switch value {
                                case .background, .inactive:
                                    security.lockApp()
                                default:
                                    break
                                }
                            })
                    }
                } header: {
                    Text("Доступ")
                }
                Section {
                    HStack {
                        Text ("Версия приложения")
                            .fontWeight(.light)
                        Spacer ()
                        Text("0.12")
                    }
                    HStack {
                        Text ("Номер сборки")
                            .fontWeight(.light)
                        Spacer ()
                        Text("9")
                    }
                } header: {
                    Text("О приложении")
                }
                Section {
                    HStack {
                        Link("ReadMe об изменениях", destination: URL(string: "https://github.com/lepranby/Tasker-App/blob/main/Tasker/App/DiplomaReadme.md")!)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "doc.text")
                    }
                } header: {
                    Text("Документация")
                }
                Section {
                    HStack {
                        Text ("Автор")
                            .fontWeight(.light)
                        Spacer ()
                        Text("Алексей Шапран")
                            .fontWeight(.regular)
                            .foregroundColor(.cyan)
                    }
                    HStack {
                        Text ("GitHub")
                            .fontWeight(.light)
                        Spacer ()
                        Link("lepranby", destination: URL(string: "https://github.com/lepranby")!)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                    }
                    HStack {
                        Text ("Twitter / X")
                            .fontWeight(.light)
                        Spacer ()
                        Link("aleksejDev", destination: URL(string: "https://twitter.com/aleksejdev?s=11")!)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                    }
                } header: {
                    Text("Об авторе")
                } footer: {
                    Text("Группа I29-onl в школе TeachMeSkills. Это мой дипломный проект. Всем спасибо за внимание и встретимся на просторах AppStore 🤓")
                        .padding(.top, 10)
                }
            }
            .navigationTitle("Настройки ")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
