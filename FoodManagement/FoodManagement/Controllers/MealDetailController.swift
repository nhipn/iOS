//
//  ViewController.swift
//  FoodManagement
//
//  Created by Chiendevj on 20/04/2024.
//

import UIKit

// B1 Tich hop cac ham uy quyen cua UITextField vao lop
class MealDetailController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
   
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var ratingMeal: UIRating!
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    // Variable meal truyền tham số giữa hai màn hình
    public var newMeal : Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // B3. Thuc hien uy quyen cac ham
        mealName.delegate = self
        
        // Kiểm tra biến meal
        if let meal = newMeal {
            navigation.title = meal.name
            mealName.text = meal.name
            mealImage.image = meal.image
            ratingMeal.rating = meal.rating
        }
    }

    // MARK: Dinh nghia cac ham uy quyen cua UITextField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Display none keyboard
        mealName.resignFirstResponder()
        return true
    }
    
    // Goi lap tuc sau khi an ban phim
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Ten mon an: \(mealName.text!)")
        navigation.title = mealName.text!
    }
    
    // MARK: Dinh nghia cac ham uy quyen cho doi tuong imagePicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Chuyen dieu khien cho ImagePicker
        dismiss(animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] {
            // Ep kieu nguoc la mot Optional
            mealImage.image =  selectedImage as? UIImage
            
        } else {
            print("Can't read the image!")
            return
        }
        
        // Back screen
        dismiss(animated: true)
    }
    // MARK: Bat su kien cho ImageView de lay anh
    
    @IBAction func imagePicker(_ sender: UITapGestureRecognizer) {
//        print("Called")
//        An ban phim
        mealName.resignFirstResponder()
        
        // Tao doi tuong UImagePickerController
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        
        // Thuc hien uy quyen cho doi tuong ImagePicker
        imagePicker.delegate = self
        // Chuyen dieu khien cho ImagePicker
        present(imagePicker, animated: true)
        
    }
    
    // MARK: Navigaiton
    
    @IBAction func backScreenHome(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        // Tạo đối tuợng newMeal dùng truyền sang màn hình A
        let name = mealName.text ?? ""
        newMeal = Meal(name: name, image: mealImage.image, rating: ratingMeal.rating)
        
    }
}
        


