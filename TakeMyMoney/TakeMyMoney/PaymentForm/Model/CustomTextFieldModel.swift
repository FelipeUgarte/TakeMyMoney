//
//  CustomTextFieldModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 03-02-23.
//

import SwiftUI

struct CustomTextFieldContentModel {
    var title: String
    var isSecure: Bool = false
    var itemLength: Int?
    let placeholder: String
    var errorMessage: String = ""
    let keyboardType: UIKeyboardType = .default
    var showImage: Bool = false
    
    var inputValue: String = ""
    var showError: Bool = false
}
