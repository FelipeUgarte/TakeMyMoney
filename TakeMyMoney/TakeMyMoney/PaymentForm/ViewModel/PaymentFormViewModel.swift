//
//  PaymentFormViewModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import SwiftUI

class PaymentFormViewModel: ObservableObject {

    @StateObject var paymentData = PaymentModel()

    @Published var shoppingCart = ShoppingCartModel()
//    @Published var paymentData = PaymentModel()
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

    /// Create a dynamic Binding to the model for all the button options.
    ///
    /// This method allows us to dynamically generate bindings for each button option based on the payment model data, enabling us to create a list of reusable button options and link each one to its corresponding state in the model.
    func binding(for opcion: PaymentOption) -> Binding<Bool> {
        return Binding(
            get: {
                self.paymentData.paymentMethod.first(where: { $0.title == opcion })?.state ?? false
            },
            set: { newValue in
                if let index = self.paymentData.paymentMethod.firstIndex(where: { $0.title == opcion }) {
                    self.paymentData.paymentMethod[index].state = newValue
                }
            }
        )
    }

//    func setTheActiveButton(index: IndexSet) {
//        for method in paymentData.paymentMethod {
//            method.state = false
//        }
//        self.paymentData.paymentMethod[index].state = true
//    }

    func selectPaymentOption(_ paymentOptionIndex: IndexSet) {
        for index in paymentData.paymentMethod.indices {
            paymentData.paymentMethod[index].state = paymentData.paymentMethod[index].title == paymentData.paymentMethod[paymentOptionIndex.hashValue].title
        }
    }

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
