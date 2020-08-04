//
//  LoginPresenter.swift
//  LogIn
//
//  Created sferea on 02/04/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class LoginPresenter: NSObject, LoginPresenterProtocol {
    
    weak var view: LoginViewControllerProtocol?
    var interactor: LoginInteractorProtocol?
    var router: LoginRouterProtocol?
    
    init(view: LoginViewControllerProtocol)
    {
        super.init()
        self.view = view
        self.initInteractor()
    }
    
    func initInteractor()
    {
        if interactor == nil
        {
            interactor = LoginInteractor()
        }
    }

    func doLogin(parametros: LoginEntity?) {
        self.view?.showIndicator()
        self.interactor?.sendLogin(parametros: parametros ?? LoginEntity(), completion: { (success, error) in
            self.view?.hideIndicator()
            if error == nil{
                self.view?.showUserView()
            } else {
                self.view?.showAlert()
            }
        })
    }
}
extension LoginPresenter: LoginInteractorOutputProtocol {
    
}
