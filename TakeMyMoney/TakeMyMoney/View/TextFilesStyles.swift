//
//  TextFilesStyles.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 03-02-23.
//

import SwiftUI

struct TextFieldStylesNormal: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .foregroundColor(.black)
            .padding(.horizontal, 16)
    }
}

struct TextFieldStylesCreditCard: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .foregroundColor(.black)
    }
}

struct TextFieldSearchStyleNormal: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
}

struct TextStylesError: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(Color(.red))
    }
}

struct TextStylesTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .textCase(.uppercase)
            .foregroundColor(.black)
            .padding(.bottom, 4)
    }
}

extension Text {
    func textStylesErrorTitle() -> some View {
        self.modifier(TextStylesError())
    }

    func textStylesTitle() -> some View {
        self.modifier(TextStylesTitle())
    }
}
