//
//  RegisterPresenter.swift
//  LogIn
//
//  Created sferea on 03/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class RegisterPresenter: NSObject, RegisterPresenterProtocol {
    
    weak var view: RegisterViewControllerProtocol?
    var interactor: RegisterInteractorProtocol?
    var router: RegisterRouterProtocol?
    
    func sendCreateAccount(parametros: UserEntity) {
        self.view?.showIndicator()
        self.interactor?.createAccount(parametros: parametros, completion: { (success, error) in
            self.view?.hideIndicator()
            if error == nil{
                self.view?.alertaSuccess(title: "Cuenta Creada", message: "La cuenta se creo exitosamente", completionOk: {
                    self.view?.navigationController?.popViewController(animated: true)
                })
            } else {
                self.view?.alertaError(title: "Ups", message: "Halgo Fallo intenta de nuevo")
            }
        })
    }
}
extension RegisterPresenter: RegisterInteractorOutputProtocol {
    
}
