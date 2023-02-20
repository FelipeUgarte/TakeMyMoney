//
//  CreditCardModel.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 25-01-23.
//

import Foundation

struct CreditCardModel {
    var number: String
    var expiryMonth: String
    var cvv: Int?
    var carHolder: String
    var saveCard: Bool
}
