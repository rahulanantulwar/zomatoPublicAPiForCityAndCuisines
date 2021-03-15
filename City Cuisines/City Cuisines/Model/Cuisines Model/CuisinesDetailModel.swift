//
//  CuisinesDetailModel.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 20/07/19.
//  Copyright © 2019 RAHUL ANANTULWAR. All rights reserved.
//

import Foundation

struct Cuisine : Codable {

    let cuisineId : Int?
    let cuisineName : String?
    
    enum CodingKeys: String, CodingKey {
        case cuisineId = "cuisine_id"
        case cuisineName = "cuisine_name"
    }
    
}

