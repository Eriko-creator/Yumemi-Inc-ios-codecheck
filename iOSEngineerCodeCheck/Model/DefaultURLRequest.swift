//
//  DefaultURLRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/10.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import Alamofire

final class DefaultURLRequest{
    
    static let shared = DefaultURLRequest()
    private init(){}
    
    func request(url: URL, completion: @escaping(AFDataResponse<Any>)->Void){
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            completion(response)
        }
    }
    
    func requestString(url: URL, completion: @escaping(String)->Void){
        AF.request(url).responseString { (response) in
            switch response.result{
            case .success(let string):
                completion(string)
            case .failure(let error):
                print(error)
            }
        }
    }
}
