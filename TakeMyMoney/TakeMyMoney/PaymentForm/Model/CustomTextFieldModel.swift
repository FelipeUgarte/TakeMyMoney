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
    var isSecure: Bool
    var itemLength: Int?
    let placeholder: String
    var showError: Bool
    var errorMessage: String
    let keyboardType: UIKeyboardType
    var showImage: Bool

    init(title: String,
         value: String = "",
         isSecure: Bool = false,
         itemLength: Int? = nil,
         placeholder: String,
         keyboardType: UIKeyboardType = .default,
         showError: Bool = false,
         errorMessage: String,
         showImage: Bool = false
    ) {
        self.title = title
        self.value = value
        self.isSecure = isSecure
        self.itemLength = itemLength
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.showError = showError
        self.errorMessage = errorMessage
        self.showImage = showImage
    }
}
