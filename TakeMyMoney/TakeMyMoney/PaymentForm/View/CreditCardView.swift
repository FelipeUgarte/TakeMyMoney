//
//  CreditCardView.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 18-03-23.
//

import SwiftUI

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
            .onChange(of: viewModel.creditCard.inputValue) { _ in
                viewModel.creditCardOnChange()
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
                .onChange(of: viewModel.cvv.inputValue) { _ in
                    viewModel.cvvOnChange()
                }
            }

            // MARK: - Card Holder Name
            CustomTextField(imputValue: $viewModel.cardHolder.inputValue,
                            title: viewModel.cardHolder.title,
                            placeholder: viewModel.cardHolder.placeholder,
                            errorMessage: viewModel.cardHolder.errorMessage,
                            showError: viewModel.cardHolder.showError)
            .onChange(of: viewModel.cardHolder.inputValue) { _ in
                viewModel.cardHolderOnChange()
            }
            Toggle(isOn: $viewModel.saveCreditCardSelected) {
                Text("Save card data for future payments")
            }
        }
    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView(viewModel: PaymentFormViewModel())
    }
}
