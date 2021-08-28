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



//@available(iOS 10.0, *)
var selected_exercise = CD_Custom()

//@available(iOS 10.0, *)
class CD_Custom : NSObject {
    static let shared = CD_Custom()
    
    let table_name = "Custom_Workout"
    
    var row_id = ""
    var type = ""
    
    var days = ""
    var user_custom_id = ""
    var user_id = ""
    var days_info = ""
    var workout_name = ""
    var exercise_id = ""
    var exercise_name = ""
    var sub_exercises = ""
    
    var arr_Fetch = [CD_Custom]()
    
    func func_save(dict:[String:Any],completionHandler:@escaping (Bool)->()) -> () {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var context: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            context = appDelegate.managedObjectContext
        }
        
        let entity = NSEntityDescription.entity(forEntityName: table_name, in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy-hh:mm:ss"
        let row_id = formatter.string(from: Date())
        
        newUser.setValue(row_id, forKey: "row_id")
        newUser.setValue("custom", forKey: "type")
        newUser.setValue("\(dict["user_custom_id"]!)", forKey: "user_custom_id")
        newUser.setValue("\(dict["user_id"]!)", forKey: "user_id")
        newUser.setValue("\(dict["workout_name"]!)", forKey: "workout_name")
        
        newUser.setValue("\(dict["days"]!)", forKey: "days")
        newUser.setValue("\(dict["days_info"]!)", forKey: "days_info")
        
        newUser.setValue("\(dict["exercise_id"]!)", forKey: "exercise_id")
        newUser.setValue("\(dict["exercise_name"]!)", forKey: "exercise_name")
        newUser.setValue("\(dict["sub_exercises"]!)", forKey: "sub_exercises")
        
        do {
            try context.save()
            completionHandler(true)
        } catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
        
    }
    
    func func_fetch(completionHandler:@escaping (Bool)->()) -> () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var context: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            context = appDelegate.managedObjectContext
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: table_name)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            arr_Fetch.removeAll()
            for data in result as! [NSManagedObject] {
                var dict_Fetch = [String:Any]()
                
                dict_Fetch["row_id"] = "\(data.value(forKey: "row_id") ?? "")"
                dict_Fetch["type"] = "\(data.value(forKey: "type") ?? "")"
                dict_Fetch["user_custom_id"] = "\(data.value(forKey: "user_custom_id") ?? "")"
                dict_Fetch["user_id"] = "\(data.value(forKey: "user_id") ?? "")"
                dict_Fetch["workout_name"] = "\(data.value(forKey: "workout_name") ?? "")"
                
                dict_Fetch["days"] = "\(data.value(forKey: "days") ?? "")"
                dict_Fetch["days_info"] = "\(data.value(forKey: "days_info") ?? "")"
                
                dict_Fetch["exercise_id"] = "\(data.value(forKey: "exercise_id") ?? "")"
                dict_Fetch["exercise_name"] = "\(data.value(forKey: "exercise_name") ?? "")"
                dict_Fetch["sub_exercises"] = "\(data.value(forKey: "sub_exercises") ?? "")"
                
                arr_Fetch.append(func_set_fetch_data(dict_Fetch: dict_Fetch))
            }
            print(arr_Fetch)
            completionHandler(true)
        } catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    private func func_set_fetch_data(dict_Fetch:[String:Any]) -> CD_Custom {
        print(dict_Fetch)
        
        let fetch_Intervals = CD_Custom()
        
        fetch_Intervals.row_id = "\(dict_Fetch["row_id"]!)"
        fetch_Intervals.type = "\(dict_Fetch["type"]!)"
        fetch_Intervals.days = "\(dict_Fetch["days"]!)"
        fetch_Intervals.user_custom_id = "\(dict_Fetch["user_custom_id"]!)"
        fetch_Intervals.user_id = "\(dict_Fetch["user_id"]!)"
        fetch_Intervals.exercise_name = "\(dict_Fetch["exercise_name"]!)"
        fetch_Intervals.days_info = "\(dict_Fetch["days_info"]!)"
        fetch_Intervals.workout_name = "\(dict_Fetch["workout_name"]!)"
        
        fetch_Intervals.exercise_id = "\(dict_Fetch["exercise_id"]!)"
        fetch_Intervals.exercise_name = "\(dict_Fetch["exercise_name"]!)"
        fetch_Intervals.sub_exercises = "\(dict_Fetch["sub_exercises"]!)"
        
        return fetch_Intervals
    }
    
    
    func func_delete(row_id:String,completionHandler:@escaping (Bool)->()) -> () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var context: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            context = appDelegate.managedObjectContext
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: table_name)
        
        request.predicate = NSPredicate(format: "row_id = %@", row_id)
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                context.delete(data)
                try context.save()
                completionHandler(true)
            }
        }  catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    
    
    func func_update(row_id:String,dict:[String:Any],completionHandler:@escaping (Bool)->()) -> () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var managedContext: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let entity = NSEntityDescription.entity(forEntityName: table_name, in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "row_id = %@",row_id)
        
        request.predicate = predicate
        do {
            let results = try managedContext.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            
            objectUpdate.setValue(row_id, forKey: "row_id")
            //            objectUpdate.setValue("\(dict["type"]!)", forKey: ""custom"")
            //            objectUpdate.setValue("\(dict["user_custom_id"]!)", forKey: "user_custom_id")
            //            objectUpdate.setValue("\(dict["user_id"]!)", forKey: "user_id")
            
            objectUpdate.setValue("\(dict["days_info"]!)", forKey: "days_info")
            objectUpdate.setValue("\(dict["days"]!)", forKey: "days")
            objectUpdate.setValue("\(dict["workout_name"]!)", forKey: "workout_name")
            
            do {
                try managedContext.save()
                completionHandler(true)
            } catch {
                print(error.localizedDescription)
                completionHandler(false)
            }
        } catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    
    func func_update_exercises(row_id:String,dict_exercises:[String:Any],completionHandler:@escaping (Bool)->()) -> () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        var managedContext: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let entity = NSEntityDescription.entity(forEntityName: table_name, in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "row_id = %@",row_id)
        
        request.predicate = predicate
        do {
            let results = try managedContext.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            
            objectUpdate.setValue(dict_exercises["exercise_id"], forKey: "exercise_id")
            objectUpdate.setValue(dict_exercises["exercise_name"], forKey: "exercise_name")
            objectUpdate.setValue(dict_exercises["sub_exercises"], forKey: "sub_exercises")
            
            do {
                try managedContext.save()
                completionHandler(true)
            } catch {
                print(error.localizedDescription)
                completionHandler(false)
            }
        } catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    
    
    func func_update_days_info(row_id:String,days_info:String,completionHandler:@escaping (Bool)->()) -> () {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var managedContext: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            managedContext = appDelegate.managedObjectContext
        }
        
        let entity = NSEntityDescription.entity(forEntityName: table_name, in: managedContext)
        let request = NSFetchRequest<NSFetchRequestResult>()
        request.entity = entity
        let predicate = NSPredicate(format: "row_id = %@",row_id)
        
        request.predicate = predicate
        
        do {
            let results = try managedContext.fetch(request)
            let objectUpdate = results[0] as! NSManagedObject
            
            objectUpdate.setValue(days_info, forKey: "days_info")
            
            do {
                try managedContext.save()
                completionHandler(true)
            } catch {
                print(error.localizedDescription)
                completionHandler(false)
            }
        } catch {
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    
    func func_delete_all_Records() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var context: NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            context = appDelegate.persistentContainer.viewContext
        } else {
            // Fallback on earlier versions
            context = appDelegate.managedObjectContext
        }
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: table_name)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }
    
    
}
