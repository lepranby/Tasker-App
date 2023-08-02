//  CustomButton.swift
//  Tasker
//
//  Created by Aleksej Shapran on 26.07.23

import Foundation
import SwiftUI

// MARK: - Стиль кнопки который используется в экране блокировки приложения с включенной функцией FaceID.

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.cyan)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
