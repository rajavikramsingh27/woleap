//
//  model_login.swift
//  Woleap
//
//  Created by Ayush Pathak on 11/11/19.
//  Copyright © 2019 appentus. All rights reserved.
//

import Foundation

class model_login {
    static let shared = model_login()
    var id = String()
    var name = String()
    var email = String()
    var mobile = String()
    var password = String()
    var start_time = String()
    var due_to = String()
    var social_id = String()
    var login_type = String()
    var is_active = String()
    var created = String()
    
    func remove_all() {
        id = String()
        name = String()
        email = String()
        mobile = String()
        password = String()
        start_time = String()
        due_to = String()
        social_id = String()
        login_type = String()
        is_active = String()
        created = String()
    }
    func print_all() {
         print(id)
         print(name)
         print(email)
         print(mobile)
         print(password)
         print(start_time)
         print(due_to)
         print(social_id)
         print(login_type)
         print(is_active)
         print(created)
    }
}
