import Combine

class PaymentModel: ObservableObject {
    @Published var paymentMethods = [
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
