//
//  SearchModel.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/01.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GithubAPIConfigure: APIConfigure{
    associatedtype JsonExport: Codable
    static func request(completion: @escaping((Result<JsonExport,APIError>)->Void))
}

extension GithubAPIConfigure{
    
    static func request(completion: @escaping((Result<JsonExport,APIError>)->Void)){
        request { (result) in
            do{
                switch result{
                case .success(let data):
                    let finalResult = try JSONDecoder().decode(JsonExport.self, from: data)
                    completion(.success(finalResult))
                case .failure(let error):
                    completion(.failure(error))
                }
            }catch{
                completion(.failure(.unknown))
                print(error)
            }
        }
    }
}

struct GithubAPI{
    
    struct GetRepositoryData: GithubAPIConfigure{
        static var path: URL?{
            let searchWord = TableViewDataSource.shared.searchWord
            let url = URL(string: "https://api.github.com/search/repositories?q=\(searchWord)")
            return url
        }
        typealias JsonExport = Repository
    }
    
    struct GetAvatarImageData: APIConfigure{
        static var path: URL?{
            let tableViewDataSource = TableViewDataSource.shared
            let repository = tableViewDataSource.repositories.items[tableViewDataSource.selectedIndex]
            let url = URL(string: repository.owner.avatarUrl)
            return url
        }
    }
    
    struct GetReadmeData: GithubAPIConfigure{
        static var path: URL?{
            let tableViewDataSource = TableViewDataSource.shared
            let repository = tableViewDataSource.repositories.items[tableViewDataSource.selectedIndex]
            let owner = repository.owner.login
            let name = repository.name
            let url = URL(string: "https://api.github.com/repos/\(owner)/\(name)/readme")
            return url
        }
        typealias JsonExport = Readme
    }
}
