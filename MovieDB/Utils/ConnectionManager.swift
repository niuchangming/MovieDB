//
//  ConnectionManager.swift
//  MovieDB
//
//  Created by Niu Changming on 25/11/20.
//  Copyright © 2020 Ekoo Lab. All rights reserved.
//

import Foundation
import Alamofire

enum Status {
    case success
    case failed(_ error: String)
}

class ConnectionManager {
    static let shared = ConnectionManager()

    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .useProtocolCachePolicy

        if let pathToCer = Bundle.main.path(forResource: "themoviedb", ofType: "cer"),
            let cerData = try? Data(contentsOf: URL(fileURLWithPath: pathToCer)) as CFData,
            let cer = SecCertificateCreateWithData(nil, cerData) {
            let serverTrustPolicies: [String: ServerTrustPolicy] = [
                Constants.SSL_HOST: ServerTrustPolicy.pinCertificates(certificates: [cer], validateCertificateChain: true, validateHost: true)
            ]
            let serverTrustPolicyManager = ServerTrustPolicyManager.init(policies: serverTrustPolicies)
            return Alamofire.SessionManager(configuration: configuration, delegate: SessionDelegate(), serverTrustPolicyManager: serverTrustPolicyManager)
        }else{
            return Alamofire.SessionManager.default
        }
    }()

    func request(method: HTTPMethod, url:String, params:[String:AnyObject]?, succeed:@escaping(AnyObject?)->(), failure:@escaping(Error?)->() ) {
        request(method: method, url: url, headers: nil, params: params, succeed: succeed, failure: failure)
    }

    func request(method: HTTPMethod, url:String, headers: HTTPHeaders?, params:[String:AnyObject]?, succeed:@escaping(AnyObject?)->(), failure:@escaping(Error?)->() ) {
        manager.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let value = response.result.value{
                    succeed(value as AnyObject)
                }
            case .failure:
                failure(response.result.error)
            }
        }
    }
}
