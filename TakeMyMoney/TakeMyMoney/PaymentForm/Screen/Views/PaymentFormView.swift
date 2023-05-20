import SwiftUI

struct PaymentFormView: View {
    @Binding var selectedMethod: PaymentOption
    let total: String
    let methods: [PaymentMethod]

    var body: some View {
        ScrollView {
            VStack(spacing: 24.0) {
                TotalPriceView(total: total)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Payment Method")
                            .font(.caption)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(methods.indices, id: \.self) { index in
                                    let paymentMethod = methods[index]
                                    PaymentOptionButton(
                                        title: paymentMethod.title.rawValue,
                                        state: paymentMethod.title == selectedMethod
                                    ) {
                                        selectedMethod = paymentMethod.title
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }

//                // MARK: - Payment Details
//                switch selectedMethod {
//                    case .credit:
//                        CreditCardView(viewModel: viewModel)
//                    case .paypal:
//                        PayPalView()
//                    case .wallet:
//                        EmptyView()
//                }
            }
            .padding()
        }
    }
}

struct PaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFormView(selectedMethod: .constant(.credit),
                        total: "2.800,00",
                        methods: [PaymentMethod(title: .credit),
                                  PaymentMethod(title: .paypal),
                                  PaymentMethod(title: .wallet)])
    }
}
