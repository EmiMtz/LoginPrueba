//
//  LoginContracts.swift
//  LogIn
//
//  Created sferea on 02/04/20.
//  Copyright © 2020 Emiliano Martinez. All rights reserved.
//

import UIKit
//Views
protocol LoginViewControllerProtocol: UIViewController {
    var presenter: LoginPresenterProtocol? {get set}
    func showUserView()
    func showAlert()
}
//Interactor
protocol LoginInteractorProtocol: NSObject {
    var output: LoginInteractorOutputProtocol? {get set}

    func sendLogin(parametros: LoginEntity, completion: @escaping ((String?,NSError?) -> Void))
}

protocol LoginInteractorOutputProtocol: NSObject {

}

//Presenter
protocol LoginPresenterProtocol: NSObject {
    var view: LoginViewControllerProtocol? {get set}
    var interactor: LoginInteractorProtocol? {get set}
    var router: LoginRouterProtocol? {get set}

    func doLogin(parametros: LoginEntity?)
}
//Router
protocol LoginRouterProtocol {
    var presenter: LoginPresenterProtocol? {get set}
    static func createModule() -> UIViewController
    
}

