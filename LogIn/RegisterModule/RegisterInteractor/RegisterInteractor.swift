//
//  RegisterInteractor.swift
//  LogIn
//
//  Created sferea on 03/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import Reqres
import Alamofire

class RegisterInteractor: NSObject, RegisterInteractorProtocol {
    
    weak var output: RegisterInteractorOutputProtocol?

    func createAccount(parametros: UserEntity, completion: @escaping ((String?, NSError?) -> Void)) {
        //Url de la petición.
        let urlServicio =  "http://blumonpay.com/user_test/register.php"
        let jsonData = try! JSONEncoder().encode(parametros)
        let jsonString = String(data: jsonData, encoding: .utf8)!
        print(jsonString)
        
        RequestManager.make(url: urlServicio, metodo: .post, parametros: parametros) { (response: Response<ResponseService>?,codeRespode: CodeResponse?, tag: Int) in
            
            var succes : String?
            var errorWS: NSError?
            var respuesta: ResponseService?
            //var match: CheckQREntity?
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
