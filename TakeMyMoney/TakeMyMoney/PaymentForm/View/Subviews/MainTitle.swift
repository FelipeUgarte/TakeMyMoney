//
//  MainTitle.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 03-02-23.
//

import SwiftUI

struct MainTitle: View {
    var titleText: String
    var showError: Bool

    var body: some View {
        Text(titleText)
            .tracking(2)
            .font(.body)
            .foregroundColor(showError ? Color(.red) : Color(.black))
            .padding(.bottom, 4)
    }
}


struct MainTitle_Previews: PreviewProvider {
    static var previews: some View {
        MainTitle(titleText: "Title",
                  showError: false)
    }
}
