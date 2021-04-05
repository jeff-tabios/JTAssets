//
//  AssetsAPI.swift
//  JTAssets
//
//  Created by Jeff Tabios on 4/3/21.
//  Copyright © 2021 Jeff Tabios. All rights reserved.
//

import Foundation

enum Endpoints {
    case getData
}

extension Endpoints {
    
    var baseURL: String {
        return "https://theirserver.com/api"
    }
    
    var endpoint: String {
        var path = ""
        switch self {
            case .getData:
            path = "/Masterdata"
        }
        
        return baseURL + path
    }
}

