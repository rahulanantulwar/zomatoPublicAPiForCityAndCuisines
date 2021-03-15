//
//  CuisinesDataHelper.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 20/07/19.
//  Copyright © 2019 RAHUL ANANTULWAR. All rights reserved.
//

import Foundation

class CuisinesDataHelper: NSObject {
    
    func getCusinesData(for cityID: Int,completion: @escaping(CusinesRootModel?, String?) -> Void){
        
        let url = ZOMATO_PUBLIC_API_FOR_CUISINES + "=\(cityID)"
        
        let objCitiesWebService = CitiesWebService()
        objCitiesWebService.getCuisinesResponse(stringURL: url, success: { (data) in
            // On Success
            do {
                let objCusinesRootModel: CusinesRootModel?
                objCusinesRootModel = try JSONDecoder().decode(CusinesRootModel.self, from: data)
                if objCusinesRootModel != nil {
                    completion(objCusinesRootModel, nil)
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
