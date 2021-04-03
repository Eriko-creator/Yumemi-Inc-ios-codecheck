//
//  SearchModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/01.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

final class GithubAPI{
    
    ///githubAPIにリクエストを投げてリポジトリのデータを取得する
    static func getRepositoryDataOf(_ searchWord:String, completion:@escaping(Result<(),APIError>)->Void){
        guard let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
        else { return completion(.failure(.invalidURL)) }
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            do{
                guard let data = response.data
                else { throw APIError.networkError }
                let result = try JSONDecoder().decode(Repository.self, from: data)
                //シングルトンに値を格納する
                let tableViewDatasource = TableViewDataSource.shared
                tableViewDatasource.repositories = result
                DispatchQueue.main.async {
                    completion(.success(()))
                }
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
    
    ///avatarImageのURLリクエストを投げてimageのデータを取得する
    static func getAvatarImageOf(_ url: URL, completion:@escaping((UIImage)->Void)){
        AF.request(url).responseJSON { (response) in
            guard let data = response.data,
                  let image = UIImage(data: data)
            else {return}
            completion(image)
        }
    }
}
