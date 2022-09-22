//
//  MaskInfo.swift
//  MaskAPIExample
//
//  Created by Leo Ho on 2022/9/21.
//

import Foundation

struct MaskInfoRequest: Codable {
    
}

struct MaskInfoResponse: Decodable {
    
    let type: String
    
    var features: [Feature]
    
    struct Feature: Decodable {
        
        let type: String
        
        var properties: Properties
        
        struct Properties: Decodable {
            
            var id: String
            
            var name: String
            
            var phone: String
            
            var address: String
            
            var mask_adult: Int
            
            var mask_child: Int
            
            var county: String
            
            var town: String
            
            var cunli: String
        }
    }
}
