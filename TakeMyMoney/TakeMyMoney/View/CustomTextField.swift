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

            textField

            if components.showError {
                Text(components.errorMessage)
                    .textStylesErrorTitle()
            }
        }
    }

    var textField: some View {
        ZStack {
            HStack(alignment: .center) {
                if components.showImage {
                    Image("VISA")
                        .padding(.leading, 16)
                        .padding(.trailing, -8)
                }

                TextField(components.placeholder ?? "", text: $components.value)
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
                    itemLength: 3,
                    showImage: false)))

            CustomTextField(
                components: .constant(CustomTextFieldModel(
                    title: "Title",
                    placeholder: "Some Text",
                    errorMessage: "Error",
                    itemLength: 3,
                    showImage: true)))
        }
    }
}


//struct CustomTextField: View {
//    var titleText: String
//    var placeholder: String
//    @Binding var value: String
//    var keyboardType: UIKeyboardType = .default
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 4) {
//            Text(titleText)
//                .tracking(2)
//                .font(.body)
//                .textCase(.uppercase)
//                .foregroundColor(.gray)
//                .padding(.bottom, 4)
//
//            textField
//        }
//    }
//
//    var textField: some View {
//        ZStack {
//            HStack(alignment: .center) {
//                Image(systemName: "arrow")
//                    .resizable()
//                    .aspectRatio(contentMode: .fill)
//                    .frame(width: 20, height: 17)
//                    .padding(.leading, 16)
//
//                TextField(
//                    placeholder,
//                    text: $value
//                    //                    onEditingChanged: { editing in
//                    //                        self.isFocused = editing
//                    //                    }
//                )
//                //                .textFieldStyle(TextFieldStylesNormal())
//                .frame(height: 48)
//                .multilineTextAlignment(.leading)
//                .keyboardType(keyboardType)
//
//            }
//            .background(
//                RoundedRectangle(cornerRadius: 8)
//                    .fill(Color.white)
//            )
//            .overlay(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(.gray,
//                            lineWidth: 1)
//                    .shadow(color: .gray,
//                            radius: 3,
//                            x: 0,
//                            y: 0)
//            )
//        }
//    }
//}
//
//struct CustomTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomTextField(titleText: "Card number",
//                        placeholder: "**** **** **** ****",
//                        value: .constant(""))
//    }
//}
