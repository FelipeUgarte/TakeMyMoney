//
//  CustomTextField.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var components: CustomTextFieldModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
                MainTitle(titleText: $components.title, showError: $components.showError)

            ZStack {
                HStack(alignment: .center) {
                    if components.showImage {
                        Image("VISA")
                            .padding(.leading, 16)
                            .padding(.trailing, -8)
                    }

                    if components.isSecure {
                        SecureField(components.placeholder, text: $components.value)
                            .textFieldStyle(TextFieldStylesNormal())
                            .frame(height: 48)
                            .multilineTextAlignment(.leading)
                            .keyboardType(components.keyboardType)
                            .onChange(of: components.value, perform: { _ in
                                guard let itemLength = components.itemLength else { return }
                                if components.value.count > itemLength {
                                    components.value = String(components.value.dropLast())
                                }
                            })

                    } else {
                        TextField(components.placeholder, text: $components.value)
                            .textFieldStyle(TextFieldStylesNormal())
                            .frame(height: 48)
                            .multilineTextAlignment(.leading)
                            .keyboardType(components.keyboardType)
                            .onChange(of: components.value, perform: { _ in
                                guard let itemLength = components.itemLength else { return }
                                if components.value.count > itemLength {
                                    components.value = String(components.value.dropLast())
                                }
                            })
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(components.showError ? .red : .gray,
                                lineWidth: 1)
                        .shadow(color: components.showError ? .red : .clear,
                                radius: 3,
                                x: 0
                                , y: 0)
                )
            }

            if components.showError {
                Text(components.errorMessage)
                    .textStylesErrorTitle()
            }
        }
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomTextField(
                components: .constant(CustomTextFieldModel(
                    title: "Title",
                    placeholder: "Some Text",
                    errorMessage: "Error",
                    showImage: false)))

            CustomTextField(
                components: .constant(CustomTextFieldModel(
                    title: "Title",
                    placeholder: "Some Text",
                    errorMessage: "Error",
                    showImage: true)))

            CustomTextField(
                components: .constant(CustomTextFieldModel(
                    title: "Title",
                    isSecure: true,
                    placeholder: "Some Text",
                    errorMessage: "Error",
                    showImage: true)))
        }
    }
}
