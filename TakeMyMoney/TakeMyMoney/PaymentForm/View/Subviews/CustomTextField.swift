//
//  CustomTextFieldV2.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 22-02-23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var imputValue: String

    var title: String
    var placeholder: String
    var errorMessage: String = ""
    var showError: Bool = false
    var showImage: Bool = false
    var isSecure: Bool = false
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            MainTitle(titleText: title, showError: showError)

            ZStack {
                HStack(alignment: .center) {
                    if showImage {
                        Image("VISA")
                            .padding(.leading, 16)
                            .padding(.trailing, -8)
                    }

                    if isSecure {
                        SecureField(placeholder, text: $imputValue)
                            .textFieldStyle(TextFieldStylesNormal())
                            .frame(height: 48)
                            .multilineTextAlignment(.leading)
                            .keyboardType(keyboardType)

                    } else {
                        TextField(placeholder, text: $imputValue)
                            .textFieldStyle(TextFieldStylesNormal())
                            .frame(height: 48)
                            .multilineTextAlignment(.leading)
                            .keyboardType(keyboardType)
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(showError ? .red : .gray,
                                lineWidth: 1)
                        .shadow(color: showError ? .red : .clear,
                                radius: 3, x: 0, y: 0)
                )
            }
            if showError {
                Text(errorMessage)
                    .textStylesErrorTitle()
            }
        }
    }
}

struct CustomTextFieldV2_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomTextField(
                imputValue: .constant(""),
                title: "Title",
                placeholder: "Some Text",
                errorMessage: "Some Error Text",
                showError: true)

            CustomTextField(
                imputValue: .constant(""),
                title: "Title",
                placeholder: "Some Text")
        }
    }
}
