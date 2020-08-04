//
//  UserProfileRouter.swift
//  LogIn
//
//  Created sferea on 04/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class UserProfileRouter: UserProfileRouterProtocol {
    
    weak var presenter: UserProfilePresenterProtocol?
    
    static func createModule() -> UIViewController {
        let s = mainstoryboard
        let view = s.instantiateViewController(withIdentifier: "UserProfile") as! UserProfileViewControllerProtocol
        var presenter: UserProfilePresenterProtocol & UserProfileInteractorOutputProtocol = UserProfilePresenter()
        var interactor:UserProfileInteractorProtocol = UserProfileInteractor()
        var router: UserProfileRouterProtocol = UserProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        router.presenter = presenter
        interactor.output = presenter
        
        return view
    }
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name: "UserProfileStoryboard", bundle: nil)
    }
}
