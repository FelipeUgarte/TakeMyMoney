//
//  PublicExtensions.swift
//  TakeMyMoney
//
//  Created by Felipe Ugarte on 12-02-23.
//

import Foundation

public extension String {

    /// Remove characters from given set from the string. Looks for characters
    /// from set in the whole string, not only its beginning and end.
    ///
    /// - Parameter set: Character set, with characters we want to remove
    /// - Returns: New String with characters from given set removed
    func removingCharactersInSet(_ characterSet: CharacterSet) -> String {
        // solution from: http://stackoverflow.com/a/32927899/4508436
        let stringParts = self.components(separatedBy: characterSet)
        let notEmptyStringParts = stringParts.filter { text in
            text.isEmpty == false
        }
        let result = notEmptyStringParts.joined(separator: "")
        return result
    }

    /// Remove whitespace and newlines characters from the string. Looks for
    /// characters from set in the whole string, not only its beginning and end.
    ///
    /// - Returns: New String with whitespace and newline characters removed
    func removingWhitespaceAndNewlines() -> String {
        return self.removingCharactersInSet(CharacterSet.whitespacesAndNewlines)
    }

    /**
     Returns formatted credit card number
     - Parameter creditCardString: Credit card number string
     - Returns: Formatted credit card number
     */
    func formatCreditCardNumber(separator: String = " ") -> String {
        let trimmedString = self.components(separatedBy: .whitespaces).joined()

        let arrOfCharacters = Array(trimmedString)
        var modifiedCreditCardString = ""

        if arrOfCharacters.count > 0 {
            for char in 0...arrOfCharacters.count - 1 {
                modifiedCreditCardString.append(arrOfCharacters[char])
                if (char + 1) % 4 == 0 && char + 1 != arrOfCharacters.count {
                    modifiedCreditCardString.append(separator)
                }
            }
        }
        return modifiedCreditCardString
    }

    func maskedCreditCardNumber() -> String {
        let lastFour = self.suffix(4)
        return String(format: "**** **** **** %@", String(lastFour))
    }
}
