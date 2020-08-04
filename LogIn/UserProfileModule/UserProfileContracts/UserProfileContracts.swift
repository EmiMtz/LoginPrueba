//
//  UserProfileContracts.swift
//  LogIn
//
//  Created sferea on 04/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
//Views
protocol UserProfileViewControllerProtocol: UIViewController {
    var presenter: UserProfilePresenterProtocol? {get set}
    
    
}
//Interactor
protocol UserProfileInteractorProtocol: NSObject {
    var output: UserProfileInteractorOutputProtocol? {get set}

}

protocol UserProfileInteractorOutputProtocol: NSObject {

}

//Presenter
protocol UserProfilePresenterProtocol: NSObject {
    var view: UserProfileViewControllerProtocol? {get set}
    var interactor: UserProfileInteractorProtocol? {get set}
    var router: UserProfileRouterProtocol? {get set}

}
//Router
protocol UserProfileRouterProtocol {
    var presenter: UserProfilePresenterProtocol? {get set}
    static func createModule() -> UIViewController
    
}

