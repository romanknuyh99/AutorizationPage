//
//  PasswordGeneration.swift
//  AutorizationPage
//
//  Created by Roman Kniukh on 4.01.21.
//

import UIKit

struct PasswordGeneration {
    static func getPassword() -> String {
        let passwordElements = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

        let arrayPassword = Array(passwordElements)
        let length = Array(arrayPassword).count
        
        var password = ""
        
        for _ in 1...8 {
            let random = Int.random(in: 0..<length)
            let randomElement = arrayPassword[random]
            password += String(randomElement)
        }
        return password
    }
}







