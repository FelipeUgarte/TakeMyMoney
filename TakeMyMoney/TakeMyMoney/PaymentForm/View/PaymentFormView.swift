//
//  ContentView.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 14-01-23.
//

import SwiftUI

struct PaymentFormView: View {
    @StateObject var viewModel = PaymentFormViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24.0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4.0) {
                            Text("Total price")
                                .font(.caption)

                            Text("$\(viewModel.shoppingCart.total)")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                    }

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Payment Method")
                                .font(.caption)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.paymentData.paymentMethod.indices, id: \.self) { index in
                                        let paymentMethod = viewModel.paymentData.paymentMethod[index]
                                        PaymentOptionButton(
                                            title: paymentMethod.title.rawValue,
                                            state: paymentMethod.title == viewModel.selectedPaymentMethod
                                        ) {
                                            viewModel.selectedPaymentMethod = paymentMethod.title
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }

                    // MARK: - Payment Details
                    switch viewModel.selectedPaymentMethod {
                        case .credit:
                            CreditCardView(viewModel: viewModel)
                        case .paypal:
                            PayPalView()
                        case .wallet:
                            EmptyView()
                    }
                }
                .padding()
            }

            Button {
                viewModel.purchaseButtonAction()
            } label: {
                Text("Proceed to confirm")
                    .padding()
            }.buttonStyle(.borderedProminent)
            .navigationTitle("Payment data")
        }
    }
}

struct PaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFormView()
    }
}
