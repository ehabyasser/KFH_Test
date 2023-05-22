//
//  ViewController.swift
//  IBAN_Validation
//
//  Created by Ihab yasser on 21/05/2023.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel:IbanValidationViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = IbanValidationViewModel(delegate: self)
        viewModel.ibanValidation(iban: "DE89370400440532013000")
        viewModel.exchangeCurrency(oldCurrency: "EUR", newcurrency: "GBP", amount: "5")
    }


}

extension ViewController:IbanValidationDelegate {
    func echangeValue(value: String) {
        print(value)
    }
    
    func ibanValid(isValid: Bool) {
        print("isValid \(isValid)")
    }

    
}
