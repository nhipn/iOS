//
//  UIRating.swift
//  FoodManagement
//
//  Created by Chiendevj on 27/04/2024.
//

import UIKit

class UIRating: UIStackView {

    // MARK: Propperties
    private var ratingValue = 0
    private var ratingButtons = [UIButton]()
    
    // Biến tính toán
    var rating : Int {
        get{
            return ratingValue
        }
        set{
            ratingValue = newValue
            updateRatingState()
            
        }
    }
    
    @IBInspectable private var starNum : Int = 5 {
        didSet{
            
            ratingSetup()
        }
    }
    @IBInspectable private var starSize : CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            ratingSetup()
        }
    }
    
    // MARK: Creare Contructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        ratingSetup()
       
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        ratingSetup()
       
        
        
    }
    
    // MARK: Create func UIRating
    private func ratingSetup() {
        // Xoa cac doi tuong cu
        for btn in ratingButtons {
            btn.removeFromSuperview()
            removeArrangedSubview(btn)
        }
        
        ratingButtons.removeAll()
        // Load ảnh từ file
        let normalPic = UIImage(named: "normal")
        let pressedPic = UIImage(named: "pressed")
        let selectedPic = UIImage(named: "selected")
        
        // Tạo đối tượng btnRating
        for _ in 0..<starNum {
            let btnRating = UIButton()
            
            // Thiết lập kích thước cho đối tượng btnRating, kích hoạt button isActive = true mới thực hiện
            btnRating.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            btnRating.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            
            // Thiết lập background
//            btnRating.backgroundColor = UIColor.green
            btnRating.setImage(normalPic, for: .normal)
            btnRating.setImage(pressedPic, for: .highlighted)
            btnRating.setImage(selectedPic, for: .selected)
            
            // EventListener for Button Rating
            btnRating.addAction(UIAction(handler: { action in
                // Get btn được nhận
                if let btn = action.sender as? UIButton {
                    // Lay vi tri cua doi tuong trong mang
                    let index = self.ratingButtons.firstIndex(of: btn)
                    let newRatingValue = index! + 1;
                    
                    self.ratingValue = (newRatingValue == self.ratingValue) ? newRatingValue - 1 : newRatingValue
                    
                    self.updateRatingState()

                }
                
            }), for: .touchUpInside)
            
            
            
            // Đưa btnRating vào đối tượng UIRating
            addArrangedSubview(btnRating)
            
            // Đưa btnRating vào array
            ratingButtons.append(btnRating)
            
        }
        // Cap nhat trang thai UIRating sau khi xay dung trong doi tuong
        updateRatingState()
    }
    
   
    
    
    // MARK: Update UIRating
    private func updateRatingState() {
        for (index, btn) in ratingButtons.enumerated() {
            
            btn.isSelected = (index < ratingValue) ? true : false
        }
    }
    
}

