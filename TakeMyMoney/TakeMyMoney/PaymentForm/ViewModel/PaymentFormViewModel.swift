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
    @Published var creditCard = CustomTextFieldModel(title: "Credit Card",
                                                     placeholder: "**** **** **** ****",
                                                     errorMessage: "Invalid Credit Card",
                                                     showImage: true)
    @Published var expirationDate = CustomTextFieldModel(title: "Expiration Date",
                                                         placeholder: "MM/DD",
                                                         errorMessage: "Invalid Date")
    @Published var cvv = CustomTextFieldModel(title: "CVV",
                                              placeholder: "***",
                                              errorMessage: "Invalid CVV")
    @Published var cardHolder = CustomTextFieldModel(title: "Card Holder",
                                                     placeholder: "Your name and suremane",
                                                     errorMessage: "Invalid Card Holder")

    @Published var saveCard: Bool = false
//    @Published var savedCreditCards: [CreditCardModel] = []

    func hideCharacters(stringToChange: String, offset: Int = 0, simbol: String) -> String {
        let text = stringToChange

        if stringToChange.count >= (offset + 1) {
            let replacement = String(repeating: simbol, count: text.count - offset)
            let range1: String.Index = text.index(text.startIndex, offsetBy: 0)
            let range2: String.Index = text.index(text.endIndex, offsetBy: -1 * offset)
            return text.replacingCharacters(in: range1..<range2, with: replacement)
        } else {
            return stringToChange
        }
    }
}
