//
//  PaymentModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 16-01-23.
//
import Combine

class PaymentModel: ObservableObject {
    var totalPrice: Double = 0
    var paymentMethod = [PaymentMethod(title: .paypal,
                                       state: false),
                         PaymentMethod(title: .credit,
                                       state: false),
                         PaymentMethod(title: .wallet,
                                       state: false)]
//    var paymentMethod = PaymentMethod(title: "Paypal", state: false)
//    var creditCard: [CreditCard] = []
}

enum PaymentOption: String, Hashable {
    case paypal = "Paypal"
    case credit = "Credit"
    case wallet = "Wallet"
}

struct PaymentMethod {
    var title: PaymentOption
    var state: Bool
}

struct CreditCard {
    var number: String
    var expiryMonth: String
    var cvv: Int?
    var carHolder: String
    var saveCard: Bool
}
