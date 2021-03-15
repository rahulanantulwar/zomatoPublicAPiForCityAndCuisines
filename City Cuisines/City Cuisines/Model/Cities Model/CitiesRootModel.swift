//
//  CitiesRootModel.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 11/02/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import Foundation

struct CitiesRootModel: Codable {
    
    let hasMore : Int?
    let hasTotal : Int?
    let locationSuggestions : [LocationSuggestionsModel]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case hasMore = "has_more"
        case hasTotal = "has_total"
        case locationSuggestions = "location_suggestions"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        hasMore = try values.decodeIfPresent(Int.self, forKey: .hasMore)
        hasTotal = try values.decodeIfPresent(Int.self, forKey: .hasTotal)
        locationSuggestions = try values.decodeIfPresent([LocationSuggestionsModel].self, forKey: .locationSuggestions)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    
}
