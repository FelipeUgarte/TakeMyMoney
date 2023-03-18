//
//  DateModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 18-03-23.
//

import Foundation

struct ExpirationDateModel {
    var title: String
    var errorMessage: String = ""

    var inputDate: Date = Date()
    var showError: Bool = false
}
