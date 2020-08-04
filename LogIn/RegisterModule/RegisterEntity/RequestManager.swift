//
//  RequestManager.swift
//  ift
//
//  Created by Emiliano on 4/08/20.
//  Copyright © 2020 Emiliano Martinez All rights reserved.
//

import Foundation
import Alamofire

// Clase para realizar peticiones genericas
class RequestManager {
    typealias Metodo = HTTPMethod
    /// crea un request generico con la información proporcionada
    /// - Parameter url: Url a la cual se le hara la petición
    /// - Parameter metodo: Selección de metodo HTTP por utilizar
    /// - Parameter parametros: Contenido que llevara la petición en caso de ser nil no tendra contenido, default nil
    /// - Parameter tipoResultado: Tipo de encodable utilizado para la respuesta, en caso de ser nil, se regresara un success con contenido vacio, default nil
    /// - Parameter delegate: Delegado que recibira las respuestas de la petición
    /// - Parameter tag: Tag que permite operaciones de tipo bandera
    static func make<A:Encodable, T:Codable>(url:String, metodo:Metodo, parametros:A?, headers: [String:String]? = nil, tag:Int = 0, completion: @escaping (T?,CodeResponse?,Int) -> ()) {
        guard let urlForRequest = URL(string: url) else {
            print("WRONG URL \(url)")
            completion(nil,CodeResponse.bad_url,tag)
            return
        }
        guard NetworkReachabilityManager()!.isReachable else {
            completion(nil,CodeResponse.not_connection,tag)
            return
        }
        var urlRequest:URLRequest = URLRequest(url: urlForRequest)
        urlRequest.httpMethod = metodo.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 15
        
        for header in headers ?? [:]{
            urlRequest.setValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if metodo != .get {
            if let contenido = parametros {
                urlRequest.httpBody = try? JSONEncoder().encode(contenido)
            }
        }
        
        print(urlRequest)
        Alamofire.request(urlRequest).responseData { (data) in
            
            switch data.result {
            case .success:
                guard let response = data.response, let value = data.data else {
                    
                    completion(nil,CodeResponse.unknow,tag)
                    
                    return
                }
                
                let code = CodeResponse(rawValue: response.statusCode) ?? CodeResponse.unknow
                if code == .unknow { print("Code not implemented \(response.statusCode)") }
                if (code == .ok) || (code == .content){
                    do {
                        let obj = try JSONDecoder().decode(T.self, from: value)
                        completion(obj,code,tag)
                    }
                    catch let jsonError{
                        print("Falied to decode Json: ",jsonError)
                        completion(nil,.bad_decodable,tag)
                    }
                } else {
                    print("Some code \(response.statusCode)")
                    let obj = try? JSONDecoder().decode(T.self, from: value)
                    completion(obj,code,tag)
                    
                }
            case .failure:
                completion(nil,.unknow,tag)
                
            }
        }
    }
}

class DummyCodable: Encodable,Decodable{}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}

public enum CodeResponse: Int {
    case ok = 200
    case content = 201
    case accepted = 202
    case none_content = 204
    case bad_request = 400
    case authentication_failed = 401
    case forbidden = 403
    case not_found = 404
    case precondition_failed = 412
    case server_error = 500
    case unknow = 520
    case not_connection = 106
    case bad_url = -1
    case bad_decodable = -2
    case not_implemented = -3
   
}

struct Response <T:Codable>: Codable
{
    var success : Bool?
    var message: String?
    var statusCode : String?
    var data: T?
    
    enum CodingKeys: String, CodingKey
    {
        case success = "success"
        case message = "message"
        case statusCode = "statusCode"
        case data = "data"
    }
}
