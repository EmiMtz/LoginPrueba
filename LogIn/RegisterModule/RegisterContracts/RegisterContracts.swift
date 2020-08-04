//
//  RegisterContracts.swift
//  LogIn
//
//  Created sferea on 03/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
//Views
protocol RegisterViewControllerProtocol: UIViewController {
    var presenter: RegisterPresenterProtocol? {get set}
    
}
//Interactor
protocol RegisterInteractorProtocol: NSObject {
    var output: RegisterInteractorOutputProtocol? {get set}
    
    func createAccount(parametros: UserEntity, completion: @escaping ((String?,NSError?) -> Void))
}

protocol RegisterInteractorOutputProtocol: NSObject {

}

//Presenter
protocol RegisterPresenterProtocol: NSObject {
    var view: RegisterViewControllerProtocol? {get set}
    var interactor: RegisterInteractorProtocol? {get set}
    var router: RegisterRouterProtocol? {get set}
    func sendCreateAccount(parametros: UserEntity)

}
//Router
protocol RegisterRouterProtocol {
    var presenter: RegisterPresenterProtocol? {get set}
    static func createModule() -> UIViewController
    
    
    
}

