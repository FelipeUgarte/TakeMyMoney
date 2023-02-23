//
//  PaymentFormViewModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import SwiftUI

class PaymentFormViewModel: ObservableObject {

    @Published var shoppingCart = ShoppingCartModel()
    @Published var paymentData = PaymentModel()
    @Published var saveCard: Bool = false

    @Published var creditCardState = CustomTextFieldStateModel()
    var creditCardTextFieldContent = CustomTextFieldContentModel(
        title: "Credit Card",
        isSecure: true,
        itemLength: 16,
        placeholder: "**** **** **** ****",
        errorMessage: "Invalid Credit Card",
        showImage: true)

    @Published var expirationDateState = CustomTextFieldStateModel()
    var expirationDateTextFieldContent = CustomTextFieldContentModel(
        title: "Expiration Date",
        placeholder: "MM/DD",
        errorMessage: "Invalid Date")
    private var previousDateTextCount: Int = 0

    @Published var cvvState = CustomTextFieldStateModel()
    var cvvTextFieldContent = CustomTextFieldContentModel(
        title: "CVV",
        placeholder: "***")

    @Published var cardHolderState = CustomTextFieldStateModel()
    var cardHolderTextFieldContent = CustomTextFieldContentModel(
        title: "Card Holder",
        placeholder: "Your name and suremane",
        errorMessage: "Invalid Card Holder")


    // MARK: - OnChange
    func creditCardOnChange(_ value: String) -> (String, Bool) {
        return (formatCreditCard(value), false)
    }

    func expirationDateOnChange(_ value: String) -> (String, Bool) {
        let formattedDate = dateFormat(value)
        print(formattedDate)
        return (formattedDate, self.checkMinDate(value))
    }

    func cvvOnChange(_ value: String) -> String {
        if value.count == 4 {
            return String(value.dropLast())
        }
        return value
    }

    // MARK: - Validations
    func formatCreditCard(_ value: String) -> String {
        return limitValueLenght(value: value, valueLength: 4)
    }

    func checkMinDate(_ date: String) -> Bool {
        guard !expirationDateState.showError else { return false }
        return !validateMinDate(date)
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

    func validateMinDate(_ date: String) -> Bool {
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

    func dateFormat(_ date: String) -> String {
        var newDateString = date

        let dateState = dateFormatState(currentDateText: newDateString, previousDateTextCount: self.previousDateTextCount)
        switch dateState {
            case .adding:
                if newDateString.count == 2 {
                    newDateString.insert("/", at: newDateString.endIndex)
                } else if newDateString.count == 1 {
                    if newDateString != "1" && newDateString != "0" {
                        newDateString = "0" + newDateString
                    }
                }
                self.expirationDateState.imputValue = newDateString
            case .extracting:
                if newDateString.count == 2 {
                    newDateString = String(newDateString.dropLast())
                }
                self.expirationDateState.imputValue = newDateString
            case .full:
                break
            case .exceeded:
                newDateString = String(newDateString.dropLast())
                self.expirationDateState.imputValue = newDateString
        }
        self.previousDateTextCount = newDateString.count
        return newDateString
    }

    private func dateFormatState(currentDateText: String, previousDateTextCount: Int) -> DateFormatterStatus {
        let maxDateCount: Int = 5

        if currentDateText.count == maxDateCount { return .full }
        if currentDateText.count > maxDateCount { return .exceeded }
        if currentDateText.count > previousDateTextCount { return .adding }
        if currentDateText.count < previousDateTextCount { return .extracting }

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

extension PaymentFormViewModel {
    enum DateFormatterStatus {
        case adding
        case extracting
        case full
        case exceeded
    }
}

