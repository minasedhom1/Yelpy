//
//  RestaurantsData.swift
//  Yelpy
//
//  Created by Mina Sedhom on 9/28/22.
//  Copyright © 2022 memo. All rights reserved.
//

import Foundation

struct RestaurantData: Decodable{
    
    let businesses: [Restaurant]
}
