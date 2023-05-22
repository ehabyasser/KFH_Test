//
//  IbanValidationViewModel.swift
//  IBAN_Validation
//
//  Created by Ihab yasser on 21/05/2023.
//

import Foundation
import Alamofire
class IbanValidationViewModel {
    
    
    private var delegate:IbanValidationDelegate
    
    init(delegate: IbanValidationDelegate) {
        self.delegate = delegate
    }
    
    
    func ibanValidation(iban:String){
        let headers:HTTPHeaders = [HTTPHeader(name: "apikey", value: "GGScfLW8bwpBIDCsLcZAOCuVUvIYWbiu")]
        NetworkManager.shared.request(url: "https://api.apilayer.com/bank_data/iban_validate?iban_number=\(iban)", method: .get , headers: headers, type: IBanValidationResponse.self) {[weak self] data, error in
            if data != nil {
                if data!.valid ?? false{
                    self?.delegate.ibanValid(isValid: true)
                }else{
                    self?.delegate.ibanValid(isValid: false)
                }
            }else if error != nil {
                print("error \(error?.localizedDescription ?? "")")
                self?.delegate.ibanValid(isValid: false)
            }
        }
        
    }
    
    func exchangeCurrency(oldCurrency:String , newcurrency:String , amount:String){
        
        let headers:HTTPHeaders = [HTTPHeader(name: "apikey", value: "OYsPIad2g6rrdlklhNi5OLQZAqH2JxPp")]
        NetworkManager.shared.request(url: "https://api.apilayer.com/fixer/convert?to=\(newcurrency)&from=\(oldCurrency)&amount=\(amount)&date=2023-05-21", method: .get , headers: headers, type: RateResponse.self) {[weak self] data, error in
            if data != nil {
                if data!.success ?? false{
                    self?.delegate.echangeValue(value: "\(data?.result ?? 0.0)")
                }else{
                    self?.delegate.echangeValue(value: "\(0.0)")
                }
            }else if error != nil {
                print("error \(error?.localizedDescription ?? "")")
                self?.delegate.echangeValue(value: "\(0.0)")
            }
        }
    }
    
}
