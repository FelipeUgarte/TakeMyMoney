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
            // MARK: - Credit Card Number
            CustomTextField(imputValue: $viewModel.creditCard.inputValue,
                            title: viewModel.creditCard.title,
                            placeholder: viewModel.creditCard.placeholder,
                            errorMessage: viewModel.creditCard.errorMessage,
                            showError: viewModel.creditCard.showError,
                            isSecure: true,
                            keyboardType: .numberPad)
            .onChange(of: viewModel.creditCard.inputValue) { newValue in
                let itemLength = viewModel.creditCard.itemLength
                (viewModel.creditCard.inputValue, viewModel.creditCard.showError) = viewModel.creditCardOnChange(value: newValue, minLength: itemLength ?? 16)
            }

            HStack(alignment: .top, spacing: 16.0) {

                // MARK: - Expiration Date
                DatePickerView(viewModel: viewModel)

                // MARK: - CVV
                CustomTextField(imputValue: $viewModel.cvv.inputValue,
                                title: viewModel.cvv.title,
                                placeholder: viewModel.cvv.placeholder,
                                errorMessage: viewModel.cvv.errorMessage,
                                showError: viewModel.cvv.showError,
                                keyboardType: .numberPad)
                .onChange(of: viewModel.cvv.inputValue) { newValue in
                    let itemLength = viewModel.cvv.itemLength
                    if let last = newValue.last, !last.isNumber {
                        viewModel.cvv.inputValue = String(newValue.dropLast())
                    }
                    (viewModel.cvv.inputValue, viewModel.cvv.showError) = viewModel.cvvOnChange(value: viewModel.cvv.inputValue, minLength: itemLength ?? 3)
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
