//
//  ContentView.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 14-01-23.
//

import SwiftUI

struct PaymentFormView: View {
    @StateObject var viewModel = PaymentFormViewModel()
    @State var selectedPaymentMethod: PaymentOption = .credit

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
                                        }
                                    }
                                }
                            }
                        }
                        Spacer()
                    }
                    // MARK: - Credit Card
                    if selectedPaymentMethod == .credit {
                        CreditCardView(viewModel: viewModel)
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

struct CreditCardView: View {
    @ObservedObject var viewModel:PaymentFormViewModel

    var body: some View {
        VStack(spacing: 16.0) {
            CustomTextField(imputValue: $viewModel.creditCard.inputValue,
                            title: viewModel.creditCard.title,
                            placeholder: viewModel.creditCard.placeholder,
                            isSecure: true,
                            keyboardType: .numberPad)
            .onChange(of: viewModel.creditCard.inputValue) { newValue in
                (viewModel.creditCard.inputValue, viewModel.creditCard.showError) = viewModel.creditCardOnChange(newValue)
            }
            HStack(spacing: 16.0) {
                // MARK: - Expiration Date
                CustomTextField(imputValue: $viewModel.expirationDate.inputValue,
                                title: viewModel.expirationDate.title,
                                placeholder: viewModel.expirationDate.placeholder,
                                keyboardType: .numberPad)
                .onChange(of: viewModel.expirationDate.inputValue) { newValue in
                    (viewModel.expirationDate.inputValue, viewModel.expirationDate.showError) = viewModel.expirationDateOnChange(newValue)
                }
                // MARK: - CVV
                CustomTextField(imputValue: $viewModel.cvv.inputValue,
                                title: viewModel.cvv.title,
                                placeholder: viewModel.cvv.placeholder,
                                keyboardType: .numberPad)
                .onChange(of: viewModel.cvv.inputValue) { newValue in
                    if let last = newValue.last, !last.isNumber {
                        viewModel.cvv.inputValue = String(newValue.dropLast())
                    }
                    viewModel.cvv.inputValue = viewModel.cvvOnChange(viewModel.cvv.inputValue)
                }
            }
            // MARK: - Card Holder Name
            CustomTextField(imputValue: $viewModel.cardHolder.inputValue,
                            title: viewModel.cardHolder.title,
                            placeholder: viewModel.cardHolder.placeholder)
            .onChange(of: viewModel.cardHolder.inputValue) { newValue in
                if let last = newValue.last, last.isNumber {
                    viewModel.cardHolder.inputValue = String(newValue.dropLast())
                }
            }
            Toggle(isOn: $viewModel.saveCard) {
                Text("Save card data for future payments")
            }
        }
    }
}
