//
//  CustomTextFieldModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 03-02-23.
//

import SwiftUI

class CustomTextFieldModel: ObservableObject {
    var title: String
    var value: String
    var unformatedValue: String
    var itemLength: Int?
    let placeholder: String?
    var showError: Bool
    var errorMessage: String
    let keyboardType: UIKeyboardType
    var showImage: Bool

    init(title: String,
         value: String = "",
         unformatedValue: String = "",
         placeholder: String? = nil,
         keyboardType: UIKeyboardType = .default,
         showError: Bool = false,
         errorMessage: String,
         itemLength: Int? = nil,
         showImage: Bool = false
    ) {
        self.title = title
        self.value = value
        self.unformatedValue = unformatedValue
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.showError = showError
        self.errorMessage = errorMessage
        self.itemLength = itemLength
        self.showImage = showImage
    }
}
