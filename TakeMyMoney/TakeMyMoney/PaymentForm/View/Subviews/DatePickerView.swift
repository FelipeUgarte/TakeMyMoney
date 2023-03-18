//
//  DatePickerView.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 18-03-23.
//

import SwiftUI

struct DatePickerView: View {
    @ObservedObject var viewModel: PaymentFormViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            MainTitle(titleText: viewModel.expirationDate.title,
                      showError: viewModel.expirationDate.showError)

            DatePicker("",
                       selection: $viewModel.expirationDate.inputDate,
                       in: Date()...,
                       displayedComponents: [.date])
            .datePickerStyle(.compact)
            .frame(height: 48)
            .padding(.trailing, 16)
            .padding(.leading, 0)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
        }
    }
}
