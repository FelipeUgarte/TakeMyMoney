//
//  PaymentModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 16-01-23.
//
import Combine

class PaymentModel: ObservableObject {
    @Published var paymentMethod = [
        PaymentMethod(title: .paypal),
        PaymentMethod(title: .credit),
        PaymentMethod(title: .wallet)
    ]
}

enum PaymentOption: String, Hashable {
    case paypal = "Paypal"
    case credit = "Credit"
    case wallet = "Wallet"
}

struct PaymentMethod {
    var title: PaymentOption
}
