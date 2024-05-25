//
//  Database.swift
//  FoodManagement
//
//  Created by  User on 18.05.2024.
//

import Foundation
import UIKit
import os.log

class Database {
    //MARK: common properties
    private let DB_NAME = "meal_management.sqlite";
    private var DB_PATH:String?;
    private var database:FMDatabase?;
    
    //MARK: tables' properties
    //1. Meal
    private let MEAL_TABLE_NAME = "meals";
    private let MEAL_ID = "_id";
    private let MEAL_NAME = "name";
    private let MEAL_IMAGE = "image";
    private let MEAL_RATING = "rating";
    
    //MARK: contructor
    init() {
        //get all paths to all folder documnets in an ios app
        let dirs = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true);
        DB_PATH = "\(dirs[0])/\(DB_NAME)";
        
        //declare database
        database = FMDatabase(path: DB_PATH);
        
        //check success
        if database != nil{
            os_log("database is now active");
            
            let query = "CREATE TABLE \(MEAL_TABLE_NAME) ("
            + "\(MEAL_ID) INTEGER PRIMARY KEY AUTOINCREMENT, "
            + "\(MEAL_NAME) TEXT, "
            + "\(MEAL_IMAGE) TEXT, "
            + "\(MEAL_RATING) INTEGER "
            + ")";
            
            if open(), !database!.tableExists(MEAL_TABLE_NAME){
                let _ = createTable(query: query);
            }
            
        } else {
            os_log("database has errors")
        }
    }
    
    //MARK: primitives methods
    //1. oepn database
    private func open()-> Bool {
        
        if database != nil{
            return database!.open();
        }
        
        os_log("cannot open database")
        return false;
    }
    
    //2. close database
    private func close() -> Bool {
        
        if database != nil {
            return database!.close();
        }
        
        os_log("cannot close database")
        return false;
    }
    
    //3. create tables
    private func createTable(query:String) ->Bool {
        
        if open() {
            return database!.executeStatements(query);
        }
        
        os_log("cannot create table");
        return false;
    }
    
    
    //MARK: api methods
    //1. api insert
    public func store(meal:Meal) ->Bool {
        
        if open() {
            //check existing table
            if database!.tableExists(MEAL_TABLE_NAME){
                let query = "INSERT INTO \(MEAL_TABLE_NAME)"
                + " (\(MEAL_NAME),\(MEAL_IMAGE),\(MEAL_RATING))"
                + " VALUES "
                + " (?,?,?)";
                
                //convert image into string
                var strImage = "";
                
                if let image = meal.image{
                    //1. convert image into NSData
                    let nsDataIMG = image.pngData()! as NSData;
                    
                    //2. convert NSData into String
                    strImage = nsDataIMG.base64EncodedString(options: .lineLength64Characters);
                }
                
                //store
                let flag = database!.executeUpdate(query, withArgumentsIn: [meal.name,strImage,meal.rating]);
                
                os_log("store meal: \(flag)");
                
                // cap nhat id moi cho meal
                meal.id = Int32(database!.lastInsertRowId)
                
                // dong csdl
                let _ = close();
                
                return flag;
            }
        }
        
        os_log("cannot store");
        return false;
    }
    
    //2. api readMeals
    public func all(meals: inout [Meal]) {
        if open() , database!.tableExists(MEAL_TABLE_NAME) {
            let query = "SELECT * FROM \(MEAL_TABLE_NAME) ORDER BY \(MEAL_RATING)";
            
            var fmRS:FMResultSet?;
            
            do {
                fmRS = try database!.executeQuery(query, values: nil);
            } catch {
                os_log("cannot query")
            }
            
            // thuc hien doc du lieu tu doi tuong FMResultSet,
            // tao bien meal moi va dua vao data src
            if let result = fmRS {
                while result.next() {
                    let name = result.string(forColumn: MEAL_NAME) ?? ""
                    let rating = result.int(forColumn: MEAL_RATING)
                    let id = result.int(forColumn: MEAL_ID)
                    
                    var image:UIImage? = nil
                    if let strImage = result.string(forColumn: MEAL_IMAGE) {
                        if !strImage.isEmpty {
                            
                            // chuyen anh thanh chuoi
                            // b1. chuyen strImage thanh Data
                            let dataImgae = Data(base64Encoded: strImage, options: .ignoreUnknownCharacters)
                            
                            // b2. chuyen dataImage thanh UIImage
                            image = UIImage(data: dataImgae!)
                        }
                    }
                    
                    // tao bien meal moi tu du lieu doc trong csdl
                    if let meal = Meal(name: name, image: image, rating: Int(rating), id: id) {
                        meals.append(meal)
                    }
                }
            }
            // dong csdl
            let _ = close()
        }
    }
    
    // 3. delete
    // 3.1 api delete by name
    func deleteMealByName(meal:Meal) -> Bool {
        if open() {
            if database!.tableExists(MEAL_TABLE_NAME) {
                let sql = "DELETE FROM \(MEAL_TABLE_NAME) WHERE \(MEAL_NAME) = ?"
                
                // thuc thi cau lenh sql
                if database!.executeUpdate(sql, withArgumentsIn: [meal.name]) {
                    os_log("xoa phan tu \(meal.name) thanh cong")
                    return true
                } else {
                    os_log("xoa phan tu \(meal.name) khong thanh cong")
                }
            }
            let _ = close()
        }
        return false
    }
    
    // 3.2. api delete by id
    func deleteMealById(id:Int32) -> Bool {
        if open() {
            if database!.tableExists(MEAL_TABLE_NAME) {
                let sql = "DELETE FROM \(MEAL_TABLE_NAME) WHERE \(MEAL_ID) = ?"
                
                // thuc thi cau lenh sql
                if database!.executeUpdate(sql, withArgumentsIn: [id]) {
                    os_log("xoa phan tu row \(id) thanh cong")
                    return true
                } else {
                    os_log("xoa phan tu row \(id) khong thanh cong")
                }
            }
            let _ = close()
        }
        return false
    }
    
    // 4. api update
    func update(meal:Meal) -> Bool {
        var OK = false;
        if open() {
            if database!.tableExists(MEAL_TABLE_NAME) {
                let sql = "UPDATE \(MEAL_TABLE_NAME) SET \(MEAL_NAME) = ?, \(MEAL_IMAGE) = ?, \(MEAL_RATING) = ? WHERE \(MEAL_ID) = ?"
                
                // chuyen anh thanh chuoi
                var strImage = ""
                if let image = meal.image {
                    
                    // b1. chuyen anh thanh NSData
                    let nsdataImage = image.pngData()! as NSData
                    
                    // b2. chuyen nddataImage thanh chuoi
                    strImage = nsdataImage.base64EncodedString(options: .lineLength64Characters)
                }
                
                // thuc hien cau lenh
                if database!.executeUpdate(sql, withArgumentsIn: [meal.name,strImage, meal.rating, meal.id]) {
                    os_log("sua thanh cong")
                    OK = true
                } else {
                    os_log("sua khong thanh cong")
                }
            }
            // dong csdl
            let _ = close()
        }
        return OK;
    }
}
