//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    
    static func getRestaurants(limit: Int, completion: @escaping ([Restaurant]?) -> Void) {
        // ––––– TODO: Add your own API key!
        let apikey = "sUAaN42bL7xKLGDoJmrI8UVKFZhKruhqZBBszZZH4hhi2uj5hjtMyCGEzg6bvJEaXcHIba9-ZGlHFuizevEqYo4RDvCS-B2ycCgoy8cJ5MmobjfGOJF203bXmTEYY3Yx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/businesses/search?latitude=\(lat)&longitude=\(long)&limit=\(limit)")!
            
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
               // print(String(decoding: data, as: UTF8.self))
                do {
                    let restaurants = try JSONDecoder().decode(RestaurantData.self, from: data).businesses
                    return completion(restaurants)
                    
                } catch {
                    print("Decoding Error: \(error)")
                    return completion(nil)
                }

//                // ––––– TODO: Get data from API and return it using completion
//                print(data)
//
//                //1. Convert Json response to a dictionary
//                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//
//                print(dataDictionary)
//
//                // 2. Grab the businesses data and convert it to an array of dictionaries
//                // for each restaurant
//                let restDictionaries =  dataDictionary["businesses"] as! [[String: Any]]
//                // 3. completion is an escaping method which allow the data to be used outside of the closure
//
//                var restaurants: [Restaurant] = []
//
//                for dict in restDictionaries {
//                    restaurants.append(.init(dict: dict))
//                }
//
                }
            }
        
            task.resume()
        
        }
    }

    
