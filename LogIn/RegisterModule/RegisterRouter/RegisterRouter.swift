//
//  RegisterRouter.swift
//  LogIn
//
//  Created sferea on 03/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class RegisterRouter: RegisterRouterProtocol {
    
    weak var presenter: RegisterPresenterProtocol?
    
    static func createModule() -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "Register") as! RegisterViewControllerProtocol
        var presenter: RegisterPresenterProtocol & RegisterInteractorOutputProtocol = RegisterPresenter()
        var interactor:RegisterInteractorProtocol = RegisterInteractor()
        var router: RegisterRouterProtocol = RegisterRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "RegisterStoryboard", bundle: nil)
    }
}
