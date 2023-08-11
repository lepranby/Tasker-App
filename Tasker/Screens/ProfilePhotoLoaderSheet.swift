//
//  ProfilePhotoLoaderSheet.swift
//  Tasker
//
//  Created by Aleksej Shapran on 11.08.23.
//

import SwiftUI

struct ProfilePhotoLoaderSheet: View {
    
    @State private var photoContainer = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Image("profile")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .padding(.bottom, 22)
                Spacer()
                HStack (spacing: 5) {
                    Button("Выбраць з галерэі") {
                        print("Hello")
                    }
                    .buttonStyle(CustomButton())
                    .padding(.leading, 100)
                    .fixedSize()
                    Button("Камера") {
                        print("Hello")
                    }
                    .buttonStyle(CustomButton())
                    .padding(.trailing, 100)
                    .fixedSize()
                }
                .padding(.bottom, 125)
                Spacer()
            }
            .padding(.top, 145)
            .navigationTitle("Змяніць фота профілю")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem (placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Адмена", systemImage: "xmark")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.red)
                    }
                }
                
                ToolbarItem {
                        NavigationLink {} label: {
                            Button {
                                    dismiss()
                            } label: {
                                Label("Захаваць", systemImage: "checkmark")
                                    .labelStyle(.iconOnly)
                                .tint(.teal) }
                        }
                    
                }
            })
        }
    }
}

struct ProfilePhotoLoaderSheet_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePhotoLoaderSheet()
    }
}
