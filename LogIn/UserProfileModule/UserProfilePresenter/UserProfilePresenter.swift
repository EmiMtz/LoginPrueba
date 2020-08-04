//
//  UserProfilePresenter.swift
//  LogIn
//
//  Created sferea on 04/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class UserProfilePresenter: NSObject, UserProfilePresenterProtocol {
    
    weak var view: UserProfileViewControllerProtocol?
    var interactor: UserProfileInteractorProtocol?
    var router: UserProfileRouterProtocol?

}
extension UserProfilePresenter: UserProfileInteractorOutputProtocol {
    
}
