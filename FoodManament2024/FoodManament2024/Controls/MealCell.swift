//
//  MealCell.swift
//  FoodManament2024
//
//  Created by  User on 04.05.2024.
//

import UIKit

class MealCell: UITableViewCell {
    
    // MARK: Properties
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var rating: UIRating!
    var onTap:UITapGestureRecognizer?
    
//    var onTap = UITapGestureRecognizer()
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
