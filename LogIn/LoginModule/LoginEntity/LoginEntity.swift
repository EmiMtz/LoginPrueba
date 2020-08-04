//
//  LoginEntity.swift
//  Beepy
//

//  Created by Emiliano Martinez on 02/04/20.
//  Copyright © 2020 EmiMtz. All rights reserved.
//

import UIKit

class LoginEntity: Encodable {
    var user: String?
    var password: String?
    
    func isValidLogin() -> Bool{
        return !(user?.isEmpty ?? true) &&
            !(password?.isEmpty ?? true)
    }
}


class TokenUserEntity: Codable{
    var tokenUsuario: String?
}
