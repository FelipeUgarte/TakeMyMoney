//
//  ButtonStyles.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 20-02-23.
//

import SwiftUI

struct ButtonStylePayment: ButtonStyle {
    var isActive: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 180, height: 50, alignment: .leading)
            .background(Color.blue)
            .cornerRadius(16)
            .shadow(color: .gray, radius: 6)
            .padding(8)
    }
}
