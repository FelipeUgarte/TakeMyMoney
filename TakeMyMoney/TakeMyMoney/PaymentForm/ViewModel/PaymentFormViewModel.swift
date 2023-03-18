//
//  PaymentFormViewModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import SwiftUI

class PaymentFormViewModel: ObservableObject {
    @Published var selectedPaymentMethod: PaymentOption = .credit
    @Published var shoppingCart = ShoppingCartModel()

    @Published var paymentData = PaymentModel()
    @Published var saveCreditCardSelected: Bool = false
    @Published var creditCard = CustomTextFieldContentModel(
        title: "Credit Card",
        isSecure: true,
        itemLength: 16,
        placeholder: "**** **** **** ****",
        errorMessage: "Invalid Credit Card",
        showImage: true)
    @Published var expirationDate = ExpirationDateModel(
        title: "Expiration Date")
    @Published var cvv = CustomTextFieldContentModel(
        title: "CVV",
        itemLength: 3,
        placeholder: "***",
        errorMessage: "Invalid CVV")
    @Published var cardHolder = CustomTextFieldContentModel(
        title: "Card Holder",
        placeholder: "Your name and suremane",
        errorMessage: "Invalid Card Holder")

    // MARK: - Button Actions
    func purchaseButtonAction() {
        errorValidations()
        if saveCreditCardSelected {
            saveCreditCard()
        }
    }

    // MARK: - OnChange
    func creditCardOnChange() {
        let value = creditCard.inputValue
        creditCard.inputValue = formatCreditCard(value)
    }

    func cvvOnChange(){
        let value = cvv.inputValue
        cvv.inputValue = limitValueLenght(value: value, valueLength: self.cvv.itemLength)
    }

    func cardHolderOnChange() {
        let value = cardHolder.inputValue
        if let last = value.last, last.isNumber {
            cardHolder.inputValue = String(value.dropLast())
        }
    }

    // MARK: - Validations
    private func formatCreditCard(_ value: String) -> String {
        return limitValueLenght(value: value, valueLength: self.creditCard.itemLength)
    }

    private func checkMinDate(_ date: String) -> Bool {
        guard !expirationDate.showError else { return false }
        return !validateMinDate(date)
    }

    private func limitValueLenght(value: String, valueLength: Int?) -> String {
        if value.removingWhitespaceAndNewlines().count > valueLength ?? 0 {
            return String(value.dropLast())
        }
        return value
    }

    private func stringWhiteSpacesFormatter() -> String {
        return ""
    }

    private func validateMinDate(_ date: String) -> Bool {
        let today = Date()
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MM"
        let todayExpiryMonth: String = dateFormatter.string(from: today)

        dateFormatter.dateFormat = "YY"
        let todayExpiryShortYear: String = dateFormatter.string(from: today)

        guard let separatorIndex = date.firstIndex(of: "/") else { return false }

        let expiryMonth = String(date.prefix(upTo: separatorIndex))
        let expiryShortYear = date.dropFirst(3)

        guard
            let todayExpiryMonthInt = Int(todayExpiryMonth),
            let todayExpiryShortYearInt = Int(todayExpiryShortYear),
            let expiryMonthInt = Int(expiryMonth),
            let expiryShortYearInt = Int(expiryShortYear) else {
            return false
        }

        if expiryShortYearInt < todayExpiryShortYearInt {
            return false
        } else if expiryShortYearInt == todayExpiryShortYearInt && expiryMonthInt < todayExpiryMonthInt {
            return false
        }
        return true
    }

    private func hasMinLenght(value: String, lenght: Int) -> Bool {
        let minLengthValid: Bool = value.count != lenght
        return minLengthValid
    }

    private func containsSpace(_ text: String) -> Bool {
        return text.contains(" ")
    }

    private func errorValidations() {
        creditCard.showError = hasMinLenght(value: creditCard.inputValue, lenght: creditCard.itemLength ?? 0)
        cvv.showError = hasMinLenght(value: cvv.inputValue, lenght: cvv.itemLength ?? 0)
        cardHolder.showError = !containsSpace(cardHolder.inputValue)
    }

    private func saveCreditCard() {

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

extension PaymentFormViewModel {
    enum DateFormatterStatus {
        case adding
        case extracting
        case full
        case exceeded
    }
}
