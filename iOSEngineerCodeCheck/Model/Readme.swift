//
//  Readme.swift
//  iOSEngineerCodeCheck
//
//  Created by 肥沼英里 on 2021/04/07.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct Readme: Codable{
    var downloadUrl: String
    
    enum CodingKeys: String, CodingKey{
        case downloadUrl = "download_url"
    }
}
