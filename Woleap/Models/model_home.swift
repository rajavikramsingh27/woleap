//
//  model_home.swift
//  Woleap
//
//  Created by Ayush Pathak on 12/11/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class model_home {
    static let shared = model_home()
    
    var get_goals_id = [String]()
    var get_goals_title = [String]()
    var get_goals_date = [String]()
    var get_goals_status = [String]()
    
    var get_tasks_id = [String]()
    var get_tasks_title = [String]()
    var get_tasks_date = [String]()
    var get_tasks_status = [String]()
    
    var get_archievements_id = [String]()
    var get_archievements_title = [String]()
    var get_archievements_date = [String]()
    var get_archievements_status = [String]()
    
    var dates = [String]()
    
    func remove_all() {
        get_goals_id = [String]()
        get_goals_title = [String]()
        get_goals_date = [String]()
        get_goals_status = [String]()
        get_tasks_id = [String]()
        get_tasks_title = [String]()
        get_tasks_date = [String]()
        get_tasks_status = [String]()
        get_archievements_id = [String]()
        get_archievements_title = [String]()
        get_archievements_date = [String]()
        get_archievements_status = [String]()
        dates = [String]()
    }
    
    func print_all() {
        print(get_goals_id)
        print(get_goals_title)
        print(get_goals_date)
        print(get_goals_status)
        print(get_tasks_id)
        print(get_tasks_title)
        print(get_tasks_date)
        print(get_tasks_status)
        print(get_archievements_id)
        print(get_archievements_title)
        print(get_archievements_date)
        print(get_archievements_status)
        print(dates)
        
    }
    
}
