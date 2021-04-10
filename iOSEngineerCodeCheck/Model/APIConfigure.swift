//
//  APIConfigure.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/20.
//

import Foundation

protocol APIConfigure{
    //APIの呼び出し先
    static var path: URL? { get }
    //リクエストする
    static func request(completion: @escaping((Result<Data,APIError>)->Void))
}

extension APIConfigure{
    
    static func request(completion: @escaping(Result<Data,APIError>)->Void){
        
        guard let path = self.path else {
            completion(.failure(.invalidURL))
            return
        }
        DefaultURLRequest.shared.request(url: path) { (response) in
            guard let data = response.data else {
                completion(.failure(.networkError))
                return
            }
            completion(.success(data))
        }
    }
}
