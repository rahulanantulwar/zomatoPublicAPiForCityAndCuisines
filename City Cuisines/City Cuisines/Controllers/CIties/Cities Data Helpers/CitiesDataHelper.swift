//
//  CitiesDataHelper.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 19/07/19.
//  Copyright © 2019 RAHUL ANANTULWAR. All rights reserved.
//

import Foundation
import UIKit

class CitiesDataHelper: NSObject {
    
    func getCitiesData(completion: @escaping(CitiesRootModel?, String?) -> Void){
        
        let cityName = "New Delhi"
        
        let url = ZOMATO_PUBLIC_API_FOR_CITIES + "=" + cityName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let objCitiesWebService = CitiesWebService()
        objCitiesWebService.getCitiesResponse(stringURL: url, success: { (data) in
            // On Success
            do {
                let citiesModel: CitiesRootModel?
                citiesModel = try JSONDecoder().decode(CitiesRootModel.self, from: data as Data)
                if citiesModel != nil {
                    completion(citiesModel, nil)
                } else {
                    completion(nil, COMMON_MESSAGE)
                }
            } catch {
                completion(nil, COMMON_MESSAGE)
            }
        },failure: { error in
            // On Error
            completion(nil, error)
        })
    }
}
