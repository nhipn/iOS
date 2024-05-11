//
//  MealTableViewController.swift
//  FoodManament2024
//
//  Created by  User on 04.05.2024.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Ptoperties
    private var meals = [Meal]()
    private let mealDetailStoryboardID = "MealDetail"
    private var selectedIndexPath:IndexPath?
    
    // dinh nghia lieu du lieu enum de danh dau duong di
    enum NavigationType{
        case newMeal
        case editMeal
    }
    
    // dinh nghia bien dung danh dau duong di
    private var navigationType:NavigationType = .newMeal
    
    @IBOutlet weak var navigation: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // them button Edit cho navigation bar
        navigation.leftBarButtonItem = editButtonItem
        
//        // tao du lieu gia cho tableView
//        if let meal = Meal(nameFood: "Muc trung hap",imageFood: UIImage(named: "default") ,ratingValue: 4){
////            meals.append(meal)
//            meals += [meal]
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    
    // ham tao cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = "MealCell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell, for: indexPath) as? MealCell {
            
            // xu ly
            // lay phan tu thu i trong mang meals
            let meal = meals[indexPath.row]
            
            // do du lieu vao cell
            cell.mealName.text = meal.nameFood
            cell.mealImage.image = meal.imageFood
            cell.rating.rating = meal.ratingValue
            
            // bo sung cho bat su kien cho doi tuong cell cach 1
            if cell.onTap == nil{

                // buoc 1. khoi tao
                cell.onTap = UITapGestureRecognizer()

                // buoc 2. bat su kien
                cell.onTap!.addTarget(self, action: #selector(editMeal))

                //buoc 3. ket noi doi tuong onTap vao cell
                cell.addGestureRecognizer(cell.onTap!)
            }
            return cell
        }
        fatalError("don't create cell!!!")
    }
    
    //selector
    @objc
    private func editMeal(_ sender:UITapGestureRecognizer){
//        print("cell tapp")
        // tao mang hinh moi
        // tao doi tuong man hinh MealDetalController
        if let detailController = self.storyboard!.instantiateViewController(withIdentifier: mealDetailStoryboardID) as? MealDetailController {
            
            // dinh vi doi tuong cell duoc tap (de biet duoc no o vi tri nao)
            if let cell = sender.view as? MealCell {
                
                // lay vi tri cua cell trong tableView
                if let indexPath = tableView.indexPath(for: cell){
                    
                    // dua lieu cn truyen vao bien mel
                    detailController.meal = meals[indexPath.row]
                    
                    //danh dau duong di
                    navigationType = .editMeal
                    
                    //luu vi tri cua cell
                    selectedIndexPath = indexPath
                    
                    //hien thi mang hinh MealDetailController
                    present(detailController, animated: true)
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
            
            // xoa meal tu data source
            meals.remove(at: indexPath.row)
            
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        
        // tao doi tuong man hinh MealDetalController
        if let detailController = self.storyboard!.instantiateViewController(withIdentifier: mealDetailStoryboardID) as? MealDetailController {
            
            //danh dau duong di
            navigationType = .newMeal
            
            //hien thi mang hinh MealDetailController
            present(detailController, animated: true)
        }
    }
    // dat trung 3: phai co 1 tham so truyen vao
    @IBAction func unwindFromMealDetail(_ segue:UIStoryboardSegue){
//        print("hello genZ")
        
        // lay meal ve, truyen sang day
        // buoc 1. lay doi tuong mang hinh B (mealDetail), lay bien meal truyen ve
        if let mealDetailController = segue.source as? MealDetailController, let meal = mealDetailController.meal {
            
            // danh dau duong di
            switch navigationType {
            case .newMeal:
                
                // buoc 2. them meal moi vao tableView
                // 2.1 them vao dataSource
                meals.append(meal)
                
                // 2.2 them doi tuong vao tableview
                let newIndexPath = IndexPath(row: meals.count - 1, section: 0)
                tableView.insertRows(at: [newIndexPath], with: .left)
                
            case .editMeal:
                
                // update lai meal trong tablView
                // buoc 1. update data source
                if let indexPath = selectedIndexPath {
                    meals[indexPath.row] = meal
                    
                    // reload lai du lieu moi cho tableView
                    tableView.reloadRows(at: [indexPath], with: .left)
                }
            }
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // lay doi tuong man hinh MealDetalController
        if let detailController = segue.destination as? MealDetailController {
            
            // cach 1.
            /*
            // dinh vi doi tuong cell duoc tap (de biet duoc no o vi tri nao)
            if let cell = sender as? MealCell {
                
                // lay vi tri cua cell trong tableView
                if let indexPath = tableView.indexPath(for: cell){
                    
                    // dua lieu cn truyen vao bien mel
                    detailController.meal = meals[indexPath.row]
                    
                    //danh dau duong di
                    navigationType = .editMeal
                    
                    //luu vi tri cua cell
                    selectedIndexPath = indexPath
                    
                    //hien thi mang hinh MealDetailController
                    present(detailController, animated: true)
                }
            }
            */
            
            
            // cach 2.
            
            // lay vi tri cua selectedCell
            if let indexPath = tableView.indexPathForSelectedRow {
                
                // dua lieu cn truyen vao bien mel
                detailController.meal = meals[indexPath.row]
                
                //danh dau duong di
                navigationType = .editMeal
                
                //luu vi tri cua cell
                selectedIndexPath = indexPath
                
                //hien thi mang hinh MealDetailController
                present(detailController, animated: true)
            }
        }
    }
}
