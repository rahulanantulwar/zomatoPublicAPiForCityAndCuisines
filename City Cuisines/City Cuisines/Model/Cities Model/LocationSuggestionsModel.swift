//
//  LocationSuggestionsModel.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 19/07/19.
//  Copyright © 2019 RAHUL ANANTULWAR. All rights reserved.
//

import Foundation

public struct LocationSuggestionsModel: Codable {
    
    let countryFlagUrl : String?
    let countryId : Int?
    let countryName : String?
    let discoveryEnabled : Int?
    let hasNewAdFormat : Int?
    let id : Int?
    let isState : Int?
    let name : String?
    let shouldExperimentWith : Int?
    let stateCode : String?
    let stateId : Int?
    let stateName : String?
    
    enum CodingKeys: String, CodingKey {
        case countryFlagUrl = "country_flag_url"
        case countryId = "country_id"
        case countryName = "country_name"
        case discoveryEnabled = "discovery_enabled"
        case hasNewAdFormat = "has_new_ad_format"
        case id = "id"
        case isState = "is_state"
        case name = "name"
        case shouldExperimentWith = "should_experiment_with"
        case stateCode = "state_code"
        case stateId = "state_id"
        case stateName = "state_name"
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        countryFlagUrl = try values.decodeIfPresent(String.self, forKey: .countryFlagUrl)
        countryId = try values.decodeIfPresent(Int.self, forKey: .countryId)
        countryName = try values.decodeIfPresent(String.self, forKey: .countryName)
        discoveryEnabled = try values.decodeIfPresent(Int.self, forKey: .discoveryEnabled)
        hasNewAdFormat = try values.decodeIfPresent(Int.self, forKey: .hasNewAdFormat)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        isState = try values.decodeIfPresent(Int.self, forKey: .isState)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        shouldExperimentWith = try values.decodeIfPresent(Int.self, forKey: .shouldExperimentWith)
        stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
        stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
    }
    
}
