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
            .frame(width: 160, height: 50, alignment: .leading)
            .background(isActive ? Color.blue : Color.gray)
            .cornerRadius(16)
            .shadow(color: .gray, radius: 6)
            .padding(8)
    }
}
