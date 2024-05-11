//
//  ViewController.swift
//  FoodManament2024
//
//  Created by  User on 20.04.2024.
//

import UIKit

// buoc 1. tich hop cac ham uy quyen cua UITextField vao lop dang dinh nghia

class MealDetailController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealRating: UIRating!
    @IBOutlet weak var navigation: UINavigationItem!
    
    // bien meal dung de truyen tham so giua 2 mang hinh
    var meal:Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // thuc hien uy quyen cho cac doi tuong
        mealName.delegate = self;
        
        // kiem tra bien meal
        if let meal = meal {
            
            // buoc 1.
            navigation.title = meal.nameFood
            mealName.text = meal.nameFood
            mealImage.image = meal.imageFood
            mealRating.rating = meal.ratingValue
        }
    }
    
    //MARK: Dinh nghia cac ham uy quyen cua UITextField
    //buoc 2:tu dinh nghia lai cac ham uy quyen
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("\(textField.text!)")
        // an ban phim
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("\(textField.text!)")
    }
    
    //MARK: bat su kien cho ImageView de lay anh ve
    
    @IBAction func imagePicker(_ sender: UITapGestureRecognizer) {
//        print("call")
        mealName.resignFirstResponder()
//        lay anh
        let imagePicker = UIImagePickerController()
//        cau hinh cho doi tuong imagePicker
        imagePicker.sourceType = .photoLibrary
        
//        thuc hien uy quyen cho doi tuong image picker
        imagePicker.delegate = self
        
//        chuyen dieu khien cho imagePicker
        present(imagePicker, animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage]{
            mealImage.image = image as? UIImage
        }
        
//         quay lai man hinh truoc do
        dismiss(animated: true)
        
    }
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
////        an man hinh hien tai
//        dismiss(animated: true)
//    }
    
    // MARK: Navigation cancel
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("prepare B")
        // tao doi tuong new meal dung de truyen sanf mang hinh A
        // bien doi
        let name = mealName.text ?? ""
        meal = Meal(nameFood: name, imageFood:mealImage.image, ratingValue: mealRating.rating)
    }
    
}

