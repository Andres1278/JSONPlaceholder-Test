//
//  ActionManager.swift
//  JSONPlaceholder Test
//
//  Created by Pedro Andres Villamil on 1/09/22.
//

import Foundation
import UIKit
import MessageUI

struct ActionManager {
    
    static func call(with number: String) {
        let cleanNumber = number.removeSpecialCharacters()
        guard let phoneURL = URL(string: "tel://\(cleanNumber)"),
              UIApplication.shared.canOpenURL(phoneURL) else {
            return
        }
        UIApplication.shared.open(phoneURL)
    }
}

extension String {
    
    func removeSpecialCharacters() -> String {
        let acceptedCharacters: CharacterSet = CharacterSet(charactersIn: "0123456789")
        return String(self.unicodeScalars.filter { acceptedCharacters.contains($0) })
    }
}
