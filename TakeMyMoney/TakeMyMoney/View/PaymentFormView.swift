//
//  ContentView.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 14-01-23.
//

import SwiftUI

struct PaymentFormView: View {
    @StateObject var paymentData = PaymentModel()
    @StateObject var creditCard = CreditCardModel()
    @State var saveCard: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24.0) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4.0) {
                            Text("Total price")
                                .font(.caption)

                            Text("$,2,280.00")
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
                            ScrollView(.horizontal) {
                                HStack {
                                    PaymentOptionButton(title: paymentData.paymentMethod[0].title,
                                                        state: $paymentData.paymentMethod [0].state)
                                    PaymentOptionButton(title: paymentData.paymentMethod[0].title,
                                                        state: $paymentData.paymentMethod[0].state)
                                    PaymentOptionButton(title: paymentData.paymentMethod[2].title,

                                                        state: $paymentData.paymentMethod[2].state)
                                }
                            }
                        }
                        Spacer()
                    }
                    VStack(spacing: 16.0) {
                        CustomTextField(titleText: "Card number",
                                        placeholder: "**** **** **** ****",
                                        value: $creditCard.numberValue)

                        HStack {
                            CustomTextField(titleText: "Valid until",
                                            placeholder: "Month / Year",
                                            value: $creditCard.expirationDate)

                            CustomTextField(titleText: "CVV",
                                            placeholder: "***",
                                            value: $creditCard.cvv)
                        }

                        CustomTextField(titleText: "Card holder",
                                        placeholder: "Your name and surname",
                                        value: $creditCard.cardHolderName)
                    }

                    Toggle(isOn: $saveCard) {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentFormView()
    }
}

struct PaymentOptionButton: View {
    var title: String
    @Binding var state: Bool

    var body: some View {
        Button {

        } label: {
            HStack {
                Text(title)
                    .font(.headline)
                    .lineLimit(1)

                Image(systemName: "checkmark.circle")
                    .font(.title)
            }
            .fontWeight(.light)
            .padding(4)
        }
        .buttonStyle(.borderedProminent)
    }
}
