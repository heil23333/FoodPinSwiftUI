//
//  RestaurantFormViewModel.swift
//  FoodPin
//
//  Created by  He on 2025/12/27.
//

import SwiftUI

@Observable class RestaurantFormViewModel {
    var name: String = ""
    var type: String = ""
    var location: String = ""
    var phone: String = ""
    var summary: String = ""
    var image: UIImage = UIImage()
    
    init(restaurant: Restaurant? = nil) {
        if let restaurant = restaurant {
            self.name = restaurant.name
            self.type = restaurant.type
            self.location = restaurant.location
            self.phone = restaurant.phone
            self.summary = restaurant.summary
            self.image = restaurant.image
        }
    }
}
