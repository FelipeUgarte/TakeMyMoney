//
//  PaymentFormViewModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import Foundation

class PaymentFormViewModel: ObservableObject {
    @Published var shoppingCart = ShoppingCartModel()
    @Published var paymentData = PaymentModel()
    @Published var creditCard = CustomTextFieldModel(
        title: "Credit Card",
        placeholder: "**** **** **** ****",
        errorMessage: "Invalid Credit Card",
        showImage: true)
    @Published var expirationDate = CustomTextFieldModel(
        title: "Expiration Date",
        placeholder: "MM/DD",
        errorMessage: "Invalid Date")
    @Published var cvv = CustomTextFieldModel(
        title: "CVV",
        placeholder: "***",
        errorMessage: "Invalid CVV")
    @Published var cardHolder = CustomTextFieldModel(
        title: "Card Holder",
        placeholder: "Your name and suremane",
        errorMessage: "Invalid Card Holder")

    @Published var saveCard: Bool = false

    func formatCreditCard() {
        let offset: Int = 4
        let simbol: String = "*"
        var stringState = FormatStringsStates.empty
        

        if let character = creditCard.value.last {
            creditCard.unformatedValue += String(character)
        } else {
            creditCard.unformatedValue = ""
        }


        creditCard.value = hideCharacters(stringToFormat: creditCard.value, offset: offset, simbol: simbol)
    }

    private func hideCharacters(stringToFormat: String, offset: Int = 0, simbol: String) -> String {
        let text = stringToFormat

        if stringToFormat.count >= (offset + 1) {
            let replacement = String(repeating: simbol, count: text.count - offset)
            let range1: String.Index = text.index(text.startIndex, offsetBy: 0)
            let range2: String.Index = text.index(text.endIndex, offsetBy: -1 * offset)
            return text.replacingCharacters(in: range1..<range2, with: replacement)
        } else {
            return stringToFormat
        }
    }

    private func stringFormatterState(imput: String, previousImputTextCount: Int) -> StringFormatterState {
        let maxStringCount: Int = 5

        if imput.count == maxStringCount { return .full }
        if imput.count > maxStringCount { return .exceeded }
        if imput.count > previousImputTextCount { return .adding }
        if imput.count < previousImputTextCount { return .extracting }

        return .adding
    }
}

extension PaymentFormViewModel {
    enum StringFormatterState {
        case adding
        case extracting
        case full
        case exceeded
    }
}
