//
//  UserEntity.swift
//  LogIn
//
//  Created by Emiliano on 03/08/20.
//  Copyright © 2020 Emiliano Martínez. All rights reserved.
//

import UIKit

struct UserEntity: Codable{
    
    var name: String?
    var lastName : String?
    var password : String?
    var email : String?
    var phoneNumber : String?
    
    func isValidCreateAccount() -> Bool{
        return !(name?.isEmpty ?? true) &&
            !(lastName?.isEmpty ?? true) &&
            !(email?.isEmpty ?? true) &&
            !(phoneNumber?.isEmpty ?? true) &&
            !(password?.isEmpty ?? true)
    }
}

class ResponseService: Codable {
    var status : Bool?
}


