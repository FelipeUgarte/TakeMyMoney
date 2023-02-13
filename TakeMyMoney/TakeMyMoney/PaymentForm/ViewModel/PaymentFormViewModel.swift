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
        isSecure: true,
        itemLength: 16,
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
        creditCard.value = limitValueLenght(value: creditCard.value, valueLength: 4)
        print(creditCard.value)
//        creditCard.value = stringWhiteSpacesFormatter()
    }

    func limitValueLenght(value: String, valueLength: Int?) -> String {
        if value.removingWhitespaceAndNewlines().count > valueLength ?? 0 {
            return String(value.dropLast())
        }
        return value
    }

    private func stringWhiteSpacesFormatter() -> String {
        return ""
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
