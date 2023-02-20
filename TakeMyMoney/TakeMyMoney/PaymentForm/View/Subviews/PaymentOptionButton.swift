//
//  PaymentOptionButton.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import SwiftUI

struct PaymentOptionButton: View {
    var title: String
    @Binding var state: Bool
    var actions: (() -> Void)? = nil

    var body: some View {
        Button {
            actions?()
        } label: {
            HStack {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(state ? .white : .black)

                Image(systemName: "checkmark.circle")
                    .font(.title)
            }
            .fontWeight(.light)
            .padding(4)
        }
        .buttonStyle(.borderedProminent)
    }
}

struct PaymentOptionButton_Previews: PreviewProvider {
    static var previews: some View {
        PaymentOptionButton(
            title: "title",
            state: .constant(false)
        )
    }
}
