//
//  CitiesWebService.swift
//  City Cuisines
//
//  Created by RAHUL ANANTULWAR on 11/02/21.
//  Copyright © 2021 RAHUL ANANTULWAR. All rights reserved.
//

import UIKit

class CitiesWebService: NSObject {
    
    //Get the cities
    func getCitiesResponse(stringURL: String,
                           success: @escaping(Data) -> Void,
                           failure: @escaping(String) -> Void) {
        
        let mainURL = URL(string: stringURL)
        var request = URLRequest(url: mainURL!)
        request.setValue(ZOMATO_API_KEY, forHTTPHeaderField: "user-key")
        
        //Create default url sessiong
        let defaultSession = URLSession(configuration: .default)
        
        //Create data task
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    // return reason for failture
                    failure(error.localizedDescription)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    success(data)
                }
            }
        }
        dataTask?.resume()
    }
    
    //Get the cuisines for a city
    func getCuisinesResponse(stringURL: String,
                           success: @escaping(Data) -> Void,
                           failure: @escaping(String) -> Void) {
        
        let mainURL = URL(string: stringURL)
        var request = URLRequest(url: mainURL!)
        request.setValue(ZOMATO_API_KEY, forHTTPHeaderField: "user-key")
        
        let defaultSession = URLSession(configuration: .default)
        
        var dataTask: URLSessionDataTask?
        
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let error = error {
                    failure(error.localizedDescription)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    //Return the data
                    success(data)
                }
            }
        }
        dataTask?.resume()
    }
    
}

