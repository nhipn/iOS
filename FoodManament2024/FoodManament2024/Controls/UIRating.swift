//
//  UIRating.swift
//  FoodManament2024
//
//  Created by  User on 27.04.2024.
//

import UIKit

class UIRating: UIStackView {
    //MARK: properties
    private var ratingValue = 0
    private var ratingButtons = [UIButton]()
    
    var rating:Int {
        get{
            return ratingValue
        }
        set {
            ratingValue = newValue
            updateRatingState()
        }
    }
    
    @IBInspectable private var starNum:Int = 5 {
        didSet{
            ratingSetup()
        }
    }
    @IBInspectable private var starSize:CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            ratingSetup()
        }
    }
    
    
    //MARK: Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingSetup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        ratingSetup()
    }
    
    //MARK: ham xay dung doi tuong UIRating
    private func ratingSetup(){
        //xoa cac doi tuong cu
        for btn in ratingButtons {
            btn.removeFromSuperview()
            removeArrangedSubview(btn)
        }
        ratingButtons.removeAll()
        
        //load anh tu file
        let normal = UIImage(named: "normal")
        let pressed = UIImage(named: "pressed")
        let selected = UIImage(named: "selected")
        
        //tao doi tuong btn-rating
        for _ in 0..<starNum {
            let btnRating = UIButton()
            //thiet lap kich thuoc cho doi tuong btnRating
            btnRating.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            btnRating.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            
            //thiet lap mau nen
//            btnRating.backgroundColor = UIColor.systemTeal
            
            btnRating.setImage(normal, for: .normal)
            btnRating.setImage(pressed, for: .highlighted)
            btnRating.setImage(selected, for: .selected)
            
            //bat su kien cho duoi tuong btnRating
            btnRating.addAction(UIAction(handler: {action in
//                print("tap on the button!")
//                lay btn duoc tap vao
                if let btn = action.sender as? UIButton{
                    
                    //lay vi tri cua doi tuong btnRating trong mang
                    let index = self.ratingButtons.firstIndex(of: btn)
                    let newRatingValue = index! + 1
                    self.ratingValue = newRatingValue == self.ratingValue ? newRatingValue - 1 : newRatingValue
                    print(self.ratingValue)
                    self.updateRatingState()
                }
            }), for: .touchUpInside)
            
            //dua btnRating vao mang
            ratingButtons.append(btnRating)
            
            //dua btn rating vao doi tuong UIRating
            addArrangedSubview(btnRating)
        }
        
        //cap nhat trang thang ui rating khi xay dung xong doi tuong
        updateRatingState()
        
    }
    
    //MARK: ham cap nhat trang thai UIRating
    private func updateRatingState(){
        for (index, btn) in ratingButtons.enumerated() {
            btn.isSelected = index < ratingValue ? true : false
        }
    }
}
