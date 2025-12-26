//
//  Restaurant.swift
//  FoodPin
//
//  Created by  He on 2025/12/22.
//

import Foundation
import Combine

class Restaurant: ObservableObject {
    //原始值类型是String, 与case名称相同, 在这里可以使用
    //CaseIterable自动提供所有case(使用.allCases)
    enum Rating: String, CaseIterable {
        case awesome
        case good
        case ok
        case bad
        case terrible
        
        var image: String {
            switch self {
            case .awesome: return "love"
            case .good: return "cool"
            case .ok: return "happy"
            case .bad: return "sad"
            case .terrible: return "angry"
            }
        }
    }
    
    //@Published 修饰的属性发生变化时, 使用该属性的View都会被通知
    @Published var name: String
    @Published var type: String
    @Published var location: String
    @Published var phone: String
    @Published var description: String
    @Published var image: String
    @Published var isFavorite: Bool
    @Published var rating: Rating?
    
    init(name: String, type: String, location: String, phone: String, description: String, image: String, isFavorite: Bool = false, rating: Rating? = nil) {
        self.name = name
        self.type = type
        self.location = location
        self.phone = phone
        self.description = description
        self.image = image
        self.isFavorite = isFavorite
        self.rating = rating
    }
}
