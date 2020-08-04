//
//  LoginInteractor.swift
//  LogIn
//
//  Created Emiliano on 02/04/20.
//  Copyright © 2020 Emiliano Martinez. All rights reserved.
//

import UIKit

class LoginInteractor: NSObject, LoginInteractorProtocol {
    
    weak var output: LoginInteractorOutputProtocol?

    func sendLogin(parametros: LoginEntity, completion: @escaping ((String?, NSError?) -> Void)) {
                //Url de la petición.
        let urlServicio =  "http://blumonpay.com/user_test/login.php"
        parametros.password = parametros.password?.MD5()
        let jsonData = try! JSONEncoder().encode(parametros)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        RequestManager.make(url: urlServicio, metodo: .get, parametros: parametros) { (response: Response<ResponseService>?,codeRespode: CodeResponse?, tag: Int) in
            
            var succes : String?
            var errorWS: NSError?
            var respuesta: ResponseService?
            
            switch codeRespode{
            case .ok,.content:
                succes = "true"
                respuesta = response?.data
                break
            case .bad_request:
                errorWS = NSError(domain:"WSLogin", code:-1,userInfo: ["message": "Verifica tus datos"])
                break
            case .server_error:
                errorWS = NSError(domain:"WSLogin", code:-1,userInfo: ["message": "El servidor no esta disponible"])
                break
            case .not_connection:
                errorWS = NSError(domain:"WSLogin", code:-1,userInfo: ["message": "No tienes internet"])
                break
            default:
                errorWS = NSError(domain:"WSLogin", code:-1,userInfo: ["message": "No service"])
                respuesta = response?.data
                break
            }
            completion(succes,errorWS)
        }
    }
}
