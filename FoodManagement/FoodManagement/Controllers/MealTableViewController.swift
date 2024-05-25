//
//  MealTableViewController.swift
//  FoodManagement
//
//  Created by Chiendevj on 04/05/2024.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    private let databse = Database();
    private var meals = [Meal]()
    @IBOutlet weak var navigation: UINavigationItem!
    private let mealDetailStoryboardID = "MealDetail"
    private var selectedIndexPath:IndexPath?
    
    // ĐỊnh nghĩa kiểu dữ liệu enum để đánh dấu đường đi
    enum NavigationType {
        case newMeal
        case editMeal
    }
    
    // Định nghĩa biến dùng đánh dấu đường đi
    private var navigationType : NavigationType = .newMeal
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Thêm Button Edit for NavigationBar
        navigation.leftBarButtonItem = editButtonItem
        
        // doc tat ca cac mon an tu csdl (neu co) va dua vao db src cua tableView
        databse.all(meals: &meals)
        
        // Tạo dữ liệu giả cho TBView
//        if let meal = Meal(name: "Dau sot ca chua", image: UIImage(named: "default"), rating: 3) {
//            meals.append(meal)
//        }
//
//        if let meal2 = Meal(name: "Banh canh ca loc", image: UIImage(named: "banh-canh"), rating: 4) {
//            meals.append(meal2)
//        }
//
//        if let meal3 = Meal(name: "Bun dau mam tom", image: UIImage(named: "bun-dau"), rating: 5) {
//            meals.append(meal3)
//        }
//
//        if let meal4 = Meal(name: "Doi nuong, long nuong", image: UIImage(named: "doi-nuong"), rating: 4) {
//            meals.append(meal4)
//        }
//
//        if let meal5 = Meal(name: "Muc kho", image: UIImage(named: "muc"), rating: 4) {
//            meals.append(meal5)
//        }
//
//        if let meal6 = Meal(name: "Oc huong mo hanh", image: UIImage(named: "oc-huong"), rating: 5) {
//            meals.append(meal6)
//        }
//
//        if let meal7 = Meal(name: "Banh bot loc", image: UIImage(named: "banh-bot-loc"), rating: 3) {
//            meals.append(meal7)
//        }
        
        
        
    }
    
    // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = "MealCell";
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? MealCell {
            
            // Lay phan tu thu i trong mang meals
            let meal = meals[indexPath.row]
            cell.mealImage.image = meal.image
            cell.mealName.text = meal.name
            cell.rating.rating = meal.rating
            
            
//             // Bổ sung cho bắt sự kiện cho cell cách 1
//             if cell.onTap == nil {
//             // Khởi tạo đối tượng onTap
//             cell.onTap = UITapGestureRecognizer()
//             // Bắt sự kiện cho đối tượng onTap
//             cell.onTap!.addTarget(self, action: #selector(editMeal))
//             // Kết nối đối tượng onTap vào cell
//             cell.addGestureRecognizer(cell.onTap!)
//             }
             
            return cell
        }
        
        // Lỗi nghiêm trọng => dùng fatalError
        fatalError("Không thể tạo Cell!")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell tab");
        if let editController = self.storyboard!.instantiateViewController(withIdentifier: mealDetailStoryboardID) as? MealDetailController {
            editController.newMeal = meals[indexPath.row]
            
            // Đánh đấu đường đi
            navigationType = .editMeal
            
            // Lưu vị trí của meal
            selectedIndexPath = indexPath
            // Hiển thị màn hình MealDetailController
            present(editController, animated: true)
        }
        
    }
    
    @objc private func editMeal(_ sender:UITapGestureRecognizer) {
        
        
        
        // Tao doi tuong man hinh MealDetailController
        if let editController = self.storyboard!.instantiateViewController(withIdentifier: mealDetailStoryboardID) as? MealDetailController {
            // Định vị đối tượng cell được tap
            if let cell = sender.view as? MealCell {
                // Lấy vị trí của cell trong tableView
                if let indexPath = tableView.indexPath(for: cell) {
                    // Lấy meal tại position tap, đưa dữ liệy cần truyền vào meal
                    editController.newMeal = meals[indexPath.row]
                    
                    // Đánh đấu đường đi
                    navigationType = .editMeal
                    
                    // Lưu vị trí của meal
                    selectedIndexPath = indexPath
                    // Hiển thị màn hình MealDetailController
                    present(editController, animated: true)
                }
                
            }
            
        }
        
        
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // xoa meal tu csdl
            let _ = databse.deleteMealById(id: meals[indexPath.row].id)
            
            // Xoá meal từ data source
            meals.remove(at: indexPath.row)
            //Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            //Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    
    @IBAction func newMeal(_ sender: UIBarButtonItem) {
        // Tao doi tuong man hinh MealDetailController
        if let detailController = self.storyboard!.instantiateViewController(withIdentifier: mealDetailStoryboardID) as? MealDetailController {
            
            // Đánh dấu đuong đi
            navigationType = .newMeal
            // Hiển thị màn hình MealDetailController
            present(detailController, animated: true)
        }
    }
    
    // MARK: Write unwind phải có @IBAction
    @IBAction func unwindFromMealDetail(_ segue:UIStoryboardSegue) {
        // 1. Lấy đối tượng từ màn hình B MealDetail và phải ép kiểu theo B,  Lấy biến newMeal truyền từ B quay về A
        if let mealDetailController = segue.source as? MealDetailController, let meal = mealDetailController.newMeal {
            
            switch navigationType {
            case .newMeal:
                // 2. Thêm newMeal vào tableView
                // 2.1. Thêm vào data source
                meals.append(meal)
                // 2.2. Thêm dòng mới vào tableView
                let newIndexPath = IndexPath(row: meals.count - 1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .left)
                
                //store into database
                let _ = databse.store(meal: meal);
                
                break
            case .editMeal:
                // Update meal trong tableView
                if let pos = selectedIndexPath {
                    
                    // lay lai id cua meal cu dua vao meal moi
                    meal.id = meals[pos.row].id

                    meals[pos.row] = meal
                    
                    // Reload dữ liệu mới cho tableView
                    tableView.reloadRows(at: [pos], with: .middle)
                    
                    // update vao db
                    let _ = databse.update(meal: meal)
                }
               
                break
            }
            
        }
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Lấy đối tượng mh MealDetailController
        if let editController = segue.destination as? MealDetailController {
            // Cách 2
            // Lấy vị trí của selectedCell trong tableView
            if let indexPath = tableView.indexPathForSelectedRow {
                // Lấy meal tại position tap, đưa dữ liệu cần truyền vào meal
                editController.newMeal = meals[indexPath.row]
                
                // Đánh đấu đường đi
                navigationType = .editMeal
                
                // Lưu vị trí của meal
                selectedIndexPath = indexPath
                // Hiển thị màn hình MealDetailController
                present(editController, animated: true)
            }
            
            /*
            // Định vị đối tượng cell được tap (Cách 1)
            if let cell = sender as? MealCell {
                // Lấy vị trí của cell trong tableView
                if let indexPath = tableView.indexPath(for: cell) {
                    // Lấy meal tại position tap, đưa dữ liệu cần truyền vào meal
                    editController.newMeal = meals[indexPath.row]
                    
                    // Đánh đấu đường đi
                    navigationType = .editMeal
                    
                    // Lưu vị trí của meal
                    selectedIndexPath = indexPath
                    // Hiển thị màn hình MealDetailController
                    present(editController, animated: true)
                }
                
            }
             */
            
            
            
        }
    }
    
}
