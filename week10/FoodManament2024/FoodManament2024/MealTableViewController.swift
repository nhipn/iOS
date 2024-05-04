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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tao du lieu gia cho tableView
        if let meal = Meal(nameFood: "Muc trung hap",imageFood: UIImage(named: "default") ,ratingValue: 4){
//            meals.append(meal)
            meals += [meal]
        }

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
            
            return cell
        }
        fatalError("don't create cell!!!")
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MealDetail") as? MealDetailController {
            
            //hien thi mang hinh MealDetailController
            present(detailController, animated: true)
        }
    }
    // dat trung 3: phai co 1 tham so truyen vao
    @IBAction func unwindFromMealDetail(_ segue:UIStoryboardSegue){
        print("hello genZ")
    }
    
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
