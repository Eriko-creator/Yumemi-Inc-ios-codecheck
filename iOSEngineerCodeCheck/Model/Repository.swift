//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/01.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Repository: Codable{
    let items: [items]
}

struct items: Codable{
    let fullName: String
    let language: String?
    let stargazersCount: Int
    let watchersCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let owner: owner
    let htmlUrl: String
    
    enum CodingKeys: String, CodingKey{
        case fullName = "full_name"
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case owner
        case htmlUrl = "html_url"
    }
}

struct owner: Codable{
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey{
        case avatarUrl = "avatar_url"
    }
}
