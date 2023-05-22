//
//  IBanValidationResponse.swift
//  IBAN_Validation
//
//  Created by Ihab yasser on 21/05/2023.
//

import Foundation
struct IBanValidationResponse: Codable {
    let valid: Bool?
    let message, iban: String?
    let ibanData: IbanData?
    let bankData: BankData?
    let countryIbanExample: String?

    enum CodingKeys: String, CodingKey {
        case valid, message, iban
        case ibanData = "iban_data"
        case bankData = "bank_data"
        case countryIbanExample = "country_iban_example"
    }
}

// MARK: - BankData
struct BankData: Codable {
    let bankCode, name, zip, city: String?
    let bic: String?

    enum CodingKeys: String, CodingKey {
        case bankCode = "bank_code"
        case name, zip, city, bic
    }
}

// MARK: - IbanData
struct IbanData: Codable {
    let country, countryCode: String?
    let sepaCountry: Bool?
    let checksum, bban, bankCode, accountNumber: String?
    let branch, nationalChecksum, countryIbanFormatAsSwift, countryIbanFormatAsRegex: String?

    enum CodingKeys: String, CodingKey {
        case country
        case countryCode = "country_code"
        case sepaCountry = "sepa_country"
        case checksum
        case bban = "BBAN"
        case bankCode = "bank_code"
        case accountNumber = "account_number"
        case branch
        case nationalChecksum = "national_checksum"
        case countryIbanFormatAsSwift = "country_iban_format_as_swift"
        case countryIbanFormatAsRegex = "country_iban_format_as_regex"
    }
}
