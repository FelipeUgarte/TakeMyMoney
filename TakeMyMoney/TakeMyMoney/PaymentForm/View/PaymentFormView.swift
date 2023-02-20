//
//  ContentView.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 14-01-23.
//

import SwiftUI

struct PaymentFormView: View {
    @StateObject var viewModel = PaymentFormViewModel()
    @State var selectedPaymentMethod: PaymentOption = .paypal

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
                                            state: paymentMethod.title == selectedPaymentMethod
                                        ) {
                                            self.selectedPaymentMethod = paymentMethod.title
                                            viewModel.selectPaymentOption(selectedPaymentMethod)
                                        }
                                    }
                                }
                            }

                        }
                        Spacer()
                    }

                    // MARK: - Credit Card
                    // TODO: Extract the credit card to a new view, it need to change to match the paiment option selected
                    VStack(spacing: 16.0) {
                        CustomTextField(
                            components: $viewModel.creditCard)
                        .onChange(of: viewModel.creditCard.value) { newValue in
                            viewModel.formatCreditCard()
                        }


                        HStack(spacing: 16.0) {
                            // MARK: - Expiration Date
                            CustomTextField(
                                components: $viewModel.expirationDate)

                            // MARK: - CVV
                            CustomTextField(
                                components: $viewModel.cvv)
                            .onChange(of: viewModel.cvv.value) { _ in
                                if viewModel.cvv.value.count == 4 {
                                    viewModel.cvv.value = String(viewModel.cvv.value.dropLast())
                                }
                            }
                        }

                        // MARK: - Card Holder Name
                        CustomTextField(
                            components: $viewModel.cardHolder)
                    }

                    Toggle(isOn: $viewModel.saveCard) {
                        Text("Save card data for future payments")
                    }

                    Spacer()

                    Button {

                    } label: {
                        Text("Proceed to confirm")
                            .padding()
                    }.buttonStyle(.borderedProminent)
                }
                .padding()
            }
            .navigationTitle("Payment data")
        }
    }
}

struct PaymentFormView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFormView()
    }
}
