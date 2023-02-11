//
//  MainTitle.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 03-02-23.
//

import SwiftUI

struct MainTitle: View {
    @Binding var titleText: String
    var showError: Binding<Bool>?

    var body: some View {
        if let showError = showError {
            Text(titleText)
                .tracking(2)
                .font(.body)
//                .textCase(.uppercase)
                .foregroundColor(showError.wrappedValue ? Color(.red) : Color(.black))
                .padding(.bottom, 4)

        } else {
            Text(titleText)
                .tracking(2)
                .font(.body)
                .textCase(.uppercase)
                .foregroundColor(Color(.black))
                .padding(.bottom, 4)
        }
    }
}


struct MainTitle_Previews: PreviewProvider {
    static var previews: some View {
        MainTitle(titleText: .constant("Title"),
                  showError: .constant(false))
    }
}
