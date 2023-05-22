//
//  IbanValidationDelegate.swift
//  IBAN_Validation
//
//  Created by Ihab yasser on 21/05/2023.
//

import Foundation
protocol IbanValidationDelegate {
    func ibanValid(isValid:Bool)
    func echangeValue(value:String)
}
