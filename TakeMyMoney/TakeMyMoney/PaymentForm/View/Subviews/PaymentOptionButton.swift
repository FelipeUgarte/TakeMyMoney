//
//  PaymentOptionButton.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import SwiftUI

struct PaymentOptionButton: View {
    var title: String
    var state: Bool
    var actions: (() -> Void)? = nil

    var body: some View {
        Button {
            actions?()
        } label: {
            HStack {
                Text(title)
                    .font(.title)
                    .lineLimit(1)
                    .foregroundColor(.white)
Spacer()
                if state {
                    Image(systemName: "checkmark.circle")
                        .font(.title)
                        .foregroundColor(.white)
                        .background(Color.blue)
                }
            }
            .fontWeight(.bold)
            .padding(.horizontal, 16)
        }
        .buttonStyle(ButtonStylePayment(isActive: state))
    }
}

struct PaymentOptionButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PaymentOptionButton(
                title: "title",
                state: false
            )

            PaymentOptionButton(
                title: "Wallet",
                state: true
            )
        }

    }
}
