//
//  Restaurant.swift
//  Yelpy
//
//  Created by Mina Sedhom on 9/28/22.
//  Copyright © 2022 memo. All rights reserved.
//

import Foundation

class Restaurant: Decodable {
    
    var imageURL: URL?
    var url: URL?
    var name: String
    var categories: [Category]
    var rating: Double
    var reviewsCount: Int
    var phone: String
    var category: String {
        categories.first?.title ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case url, rating, name, phone, categories
        case imageURL = "image_url"
        case reviewsCount = "review_count"
    }
    
    
//    init(dict: [String: Any]) {
//
//        imageURL = URL(string: dict["image_url"] as! String)
//        name = dict["name"] as! String
//        rating = dict["rating"] as! Double
//        reviewsCount = dict["review_count"] as! Int
//        phone = dict["phone"] as! String
//
//
//        url = URL(string: dict["url"] as! String)
//        let categories = dict["categories"] as! [[String: Any?]]    // { ( {}, {} )}
//        category = categories[0]["title"] as! String
//
//    }
}
