//
//  MealCell.swift
//  FoodManagement
//
//  Created by Chiendevj on 04/05/2024.
//

import UIKit

class MealCell: UITableViewCell {

    // Properties
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var rating: UIRating!
    @IBOutlet weak var mealName: UILabel!
    var onTap: UITapGestureRecognizer?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //
        if onTap != nil {
            onTap!.delegate = self;
        }
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return (touch.view == self.contentView);
    }

}
