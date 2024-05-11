//
//  Meal.swift
//  FoodManament2024
//
//  Created by  User on 04.05.2024.
//

import UIKit

class Meal {
    
    // MARK: Properties
    var nameFood:String
    var imageFood:UIImage?
    var ratingValue:Int
    
    //MARK: Contructors
    init?(nameFood: String, imageFood: UIImage? = nil, ratingValue: Int) {
        
        if nameFood.isEmpty{
            return nil
        }
        
        if ratingValue < 0 || ratingValue > 5 {
            return nil
        }
        
        self.nameFood = nameFood
        self.imageFood = imageFood
        self.ratingValue = ratingValue
    }
}
