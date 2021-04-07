//
//  APIConfigure.swift
//  DriveSimulator
//
//  Created by 肥沼英里 on 2021/02/20.
//

import Foundation
import Alamofire

protocol APIConfigure{
    //APIの呼び出し先
    static var path: URL? { get }
    //リクエストする
    static func request(completion: @escaping((Result<Data,APIError>)->Void))
}

extension APIConfigure{
    
    static func request(completion: @escaping(Result<Data,APIError>)->Void){
        
        guard let path = self.path else {
            return completion(.failure(.invalidURL))
        }
        AF.request(path, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            do{
                guard let data = response.data else {
                    throw APIError.networkError
                }
                completion(.success(data))
            }catch{
                if error as? APIError == APIError.networkError{
                    completion(.failure(.networkError))
                }else{
                    completion(.failure(.unknown))
                }
                print(error)
            }
        }
    }
}
