//
//  NetworkManager.swift
//  IBAN_Validation
//
//  Created by Ihab yasser on 21/05/2023.
//

import Foundation
import Alamofire

class NetworkManager{
    
    static let shared:NetworkManager = NetworkManager()
    private let sessionManager: Session
    private init() {
        let serverCertificateName = "sni.cloudflaressl.com" // The name of your certificate file
        let serverCertificate = Bundle.main.path(forResource: serverCertificateName, ofType: "cer")
        let serverCertificateData = try! Data(contentsOf: URL(fileURLWithPath: serverCertificate!))
        
        let trustEvaluator = CustomServerTrustEvaluator(certificateData: serverCertificateData)
        
        let serverTrustManager = ServerTrustManager(evaluators: ["api.apilayer.com": trustEvaluator])
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        
        sessionManager = Session(configuration: configuration, serverTrustManager: serverTrustManager)
    }
    
    
    func request<T:Codable>(url:String , method:HTTPMethod , params:Parameters? = nil , headers:HTTPHeaders? = nil , type:T.Type , completion:@escaping (_ data:T? , _ error:Error?) -> ()){
        
        sessionManager.request(url , method: method , parameters: params , headers: headers).response { response in
            if response.error != nil {
                completion(nil , response.error)
            }
            if response.data != nil {
                do{
                    print(String(data: response.data!, encoding: .utf8) ?? "")
                    let decoder = JSONDecoder()
                    let res = try decoder.decode(T.self, from: response.data!)
                    completion(res , nil)
                }catch {
                    completion(nil , error)
                }
            }
        }
        
    }
    
}


class CustomServerTrustEvaluator: ServerTrustEvaluating {
    let certificateData: Data
    
    init(certificateData: Data) {
        self.certificateData = certificateData
    }
    
    func evaluate(_ trust: SecTrust, forHost host: String) throws {
        guard let serverCertificate = SecTrustGetCertificateAtIndex(trust, 0) else {
            throw AFError.serverTrustEvaluationFailed(reason: .noCertificatesFound)
        }
        
        // Compare the server's certificate with your certificate data
        let serverCertificateData = SecCertificateCopyData(serverCertificate) as Data
        if serverCertificateData != certificateData {
            throw AFError.serverTrustEvaluationFailed(reason: .certificatePinningFailed(host: host, trust: trust, pinnedCertificates: [], serverCertificates: []))
        }
    }
}

