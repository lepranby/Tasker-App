//  SettingsView.swift
//  Tasker
//
//  Created by Aleksej Shapran on 13.07.23

import SwiftUI

struct SettingsView: View {
    
    @StateObject private var security = SecurityData()
    @Environment(\.scenePhase) var scenePhase
    
    @State private var profileSheet = false
    private var username = "Aleksej Shapran"
    
    var content: some View {
        Toggle("Выкарыстоўваць FaceID", isOn: $security.isAppLockEnabled)
            .fontWeight(.light)
            .onChange(of: security.isAppLockEnabled, perform: { value in
                security.appLockStateChange(value)
            })
            .tint(.cyan)
            .fullScreenCover(isPresented: $security.isLocked, content: {
                LockedView()
                    .environmentObject(security)
                    .interactiveDismissDisabled()
            })
    }
    
    var body: some View {
        
        NavigationView {
            Form {
                Section {
                    HStack{
                        Text("Змяніць фота профілю")
                            .fontWeight(.light)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "camera.shutter.button")
                    }
                }
                .onTapGesture {
                    withAnimation { self.profileSheet.toggle() }
                }
                Section {
                    HStack {
                        Button("Адзначаныя нататкі") {
                            print("Hello")
                        }
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                    }
                    HStack {
                        Button("Мова") {
                            print("Hello")
                        }
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "chevron.right")
                                .font(.system(size: 14))
                    }
                }
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
                    Text("Настройка доступу")
                } footer: {
                    Text("Калі настройка ўключана, дадатак будзе блакавацца ў фонавым рэжыме, або пры яго паўторным запуску.")
                }
                Section {
                    HStack {
                        Text ("Версія")
                            .fontWeight(.light)
                        Spacer ()
                        Text("1.19")
                    }
                    HStack {
                        Text ("Нумар сборцы")
                            .fontWeight(.light)
                        Spacer ()
                        Text("11")
                    }
                } header: {
                    Text("Аб дадатку")
                }
                Section {
                    HStack{
                        Link("Перайсці на GitHub праекта", destination: URL(string: "https://github.com/lepranby")!)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "qrcode")
                    }
                    HStack{
                        Link("Напісаць аўтару ў Twitter / X", destination: URL(string: "https://twitter.com/aleksejdev?s=11")!)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "bird")
                    }
                    HStack {
                        Link("Чытаць ReadMe аб зменах", destination: URL(string: "https://github.com/lepranby/Tasker-App/blob/main/Tasker/App/DiplomaReadme.md")!)
                            .fontWeight(.light)
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "doc.text")
                    }
                } header: {
                    Text("Тэхнічная падтрымка")
                }
            }
            .scrollIndicators(.hidden)
            .navigationTitle("Налады")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
                leading:
                    Text(username)
                    .font(.body)
                    .foregroundColor(Color(.systemGray)),
                trailing:
                Image("profile")
                    .resizable()
                    .frame(width: 34, height: 34)
                    .clipShape(Circle())
                    .contextMenu(menuItems: {
                        Button {
                            // action saved profile photo
                        } label: { Label("Змяніць фота профілю", systemImage: "camera.on.rectangle") }
                    }, preview: {
                        Image("profile")
                            .resizable()
                            .frame(width: 160, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    })
            )
        }
        .sheet(isPresented: $profileSheet) {
            ProfilePhotoLoaderSheet()
                .presentationDetents([.fraction(0.6)])
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
