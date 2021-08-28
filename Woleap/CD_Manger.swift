//
//  File.swift
//  Woleap
//
//  Created by appentus technologies pvt. ltd. on 8/26/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CD_Manger : NSObject {
    static let shared = CD_Manger()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func add_data_to_database(_ arr_value: [String], _ tbl_name : database_tables, completion :(Bool)->()) {
        
        var context: NSManagedObjectContext
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            context = appDelegate.managedObjectContext
        }
        
        switch tbl_name {
        case .login:
            delete_all_from_database(.login) { (_) in
                let entity = NSEntityDescription.entity(forEntityName: "Login", in: context)
                let new_data = NSManagedObject(entity: entity!, insertInto: context)
                new_data.setValue(arr_value[0], forKey: "id")
                new_data.setValue(arr_value[1], forKey: "name")
                new_data.setValue(arr_value[2], forKey: "email")
                new_data.setValue(arr_value[3], forKey: "mobile")
                new_data.setValue(arr_value[4], forKey: "password")
                new_data.setValue(arr_value[5], forKey: "start_time")
                new_data.setValue(arr_value[6], forKey: "due_to")
                new_data.setValue(arr_value[7], forKey: "social_id")
                new_data.setValue(arr_value[8], forKey: "login_type")
                new_data.setValue(arr_value[9], forKey: "is_active")
                new_data.setValue(arr_value[10] , forKey: "created")
                new_data.setValue(1, forKey: "db_id")
                do {
                    try context.save()
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                }
            }
        case .Get_home_data:
            delete_all_from_database(.Get_home_data) { (_) in
                let entity = NSEntityDescription.entity(forEntityName: "Get_home_data", in: context)
                let new_data = NSManagedObject(entity: entity!, insertInto: context)
                new_data.setValue(arr_value[0], forKey: "get_goals")
                new_data.setValue(arr_value[1], forKey: "get_tasks")
                new_data.setValue(arr_value[2], forKey: "get_archievements")
                new_data.setValue(arr_value[3], forKey: "dates")
                new_data.setValue(1, forKey: "db_id")
                do {
                    try context.save()
                    completion(true)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func fetch_result(_ tbl_name : database_tables) {
        switch tbl_name {
        case .login:
            model_login.shared.remove_all()
            var managedContext: NSManagedObjectContext
            if #available(iOS 10.0, *) {
                managedContext = appDelegate.persistentContainer.viewContext
            } else {
                managedContext = appDelegate.managedObjectContext
            }
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
            request.sortDescriptors = [NSSortDescriptor(key: "db_id", ascending: true)]
            
            do{
                let result = try managedContext.fetch(request)
                if result.count > 0{
                    let data = result[0] as! NSManagedObject
                    model_login.shared.id = "\(data.value(forKey: "id")!)"
                    model_login.shared.name = "\(data.value(forKey: "name")!)"
                    model_login.shared.email = "\(data.value(forKey: "email")!)"
                    model_login.shared.mobile = "\(data.value(forKey: "mobile")!)"
                    model_login.shared.password = "\(data.value(forKey: "password")!)"
                    model_login.shared.start_time = "\(data.value(forKey: "start_time")!)"
                    model_login.shared.due_to = "\(data.value(forKey: "due_to")!)"
                    model_login.shared.social_id = "\(data.value(forKey: "social_id")!)"
                    model_login.shared.login_type = "\(data.value(forKey: "login_type")!)"
                    model_login.shared.is_active = "\(data.value(forKey: "is_active")!)"
                    model_login.shared.created = "\(data.value(forKey: "created")!)"
                }else{
                    model_login.shared.id = ""
                    model_login.shared.name = ""
                    model_login.shared.email = ""
                    model_login.shared.mobile = ""
                    model_login.shared.password = ""
                    model_login.shared.start_time = ""
                    model_login.shared.due_to = ""
                    model_login.shared.social_id = ""
                    model_login.shared.login_type = ""
                    model_login.shared.is_active = ""
                    model_login.shared.created = ""
                }
            }
            catch{
                print(error.localizedDescription)
            }
        case .Get_home_data:
            model_home.shared.remove_all()
            var managedContext: NSManagedObjectContext
            if #available(iOS 10.0, *) {
                managedContext = appDelegate.persistentContainer.viewContext
            } else {
                managedContext = appDelegate.managedObjectContext
            }
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Get_home_data")
            request.sortDescriptors = [NSSortDescriptor(key: "db_id", ascending: true)]
            
            do{
                let result = try managedContext.fetch(request)
                if result.count > 0{
                    let data = result[0] as! NSManagedObject
                    
                    var get_goals = NSArray()
                    var get_tasks = NSArray()
                    var get_archievements = NSArray()
                    var dates = NSArray()
                    
                    let str_get_goals = "\(data.value(forKey: "get_goals")!)"
                    get_goals = string_to_array(object: str_get_goals)

                    for i in 0..<get_goals.count{
                        let dict = get_goals[i] as! NSDictionary
                        model_home.shared.get_goals_id.append("\(dict["id"]!)")
                        model_home.shared.get_goals_title.append("\(dict["title"]!)")
                        model_home.shared.get_goals_date.append("\(dict["date"]!)")
                        model_home.shared.get_goals_status.append("\(dict["status"]!)")
                    }
                    
                    let str_get_tasks = "\(data.value(forKey: "get_tasks")!)"
                    get_tasks = string_to_array(object: str_get_tasks)
                    
                    for i in 0..<get_tasks.count{
                        let dict = get_tasks[i] as! NSDictionary
                        model_home.shared.get_tasks_id.append("\(dict["id"]!)")
                        model_home.shared.get_tasks_title.append("\(dict["name"]!)")
                        model_home.shared.get_tasks_date.append("\(dict["start_date"]!)")
                        model_home.shared.get_tasks_status.append("\(dict["status"]!)")
                    }
                    
                    let str_get_archievements = "\(data.value(forKey: "get_archievements")!)"
                    get_archievements = string_to_array(object: str_get_archievements)
                    
                    for i in 0..<get_archievements.count{
                        let dict = get_archievements[i] as! NSDictionary
                        model_home.shared.get_archievements_id.append("\(dict["id"]!)")
                        model_home.shared.get_archievements_title.append("\(dict["title"]!)")
                        model_home.shared.get_archievements_date.append("\(dict["date"]!)")
                        model_home.shared.get_archievements_status.append("\(dict["status"]!)")
                    }
                    
                    let str_get_dates = "\(data.value(forKey: "dates")!)"
                    dates = string_to_array(object: str_get_dates)
                    
                    for i in 0..<dates.count{
                        model_home.shared.dates.append("\(dates[i])")
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func delete_all_from_database(_ tbl_name : database_tables, completion:(Bool)->()) {
        switch tbl_name {
        case .login:
            var context: NSManagedObjectContext
            if #available(iOS 10.0, *) {
                context = appDelegate.persistentContainer.viewContext
            } else {
                // Fallback on earlier versions
                context = appDelegate.managedObjectContext
            }
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Login")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
                completion(true)
            } catch {
                print ("There was an error")
                completion(false)
            }
        case .Get_home_data:
            var context: NSManagedObjectContext
            if #available(iOS 10.0, *) {
                context = appDelegate.persistentContainer.viewContext
            } else {
                // Fallback on earlier versions
                context = appDelegate.managedObjectContext
            }
            
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Get_home_data")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try context.execute(deleteRequest)
                try context.save()
                completion(true)
            } catch {
                print ("There was an error")
                completion(false)
            }
        }
    }
}

enum database_tables {
    case login
    case Get_home_data
}
