//
//  ViewController.swift
//  LogIn
//

//  Created by Emiliano Martinez on 03/08/20.
//  Copyright © 2020 EmiMtz. All rights reserved.
//

import UIKit
//import Reqres

class LoginViewController: UIViewController,LoginViewControllerProtocol {

    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    var presenter: LoginPresenterProtocol?
    
    var formulario = LoginEntity(){
        didSet{
            verifiedData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = LoginPresenter(view: self)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor.mainPink()
        loginButton.layer.cornerRadius = 5
        
        userTextfield.attributedPlaceholder = NSAttributedString.init(string: "Usuario...", attributes: [kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.white])
        passwordTextfield.attributedPlaceholder = NSAttributedString.init(string: "Password...", attributes: [kCTForegroundColorAttributeName as NSAttributedString.Key: UIColor.white])
        
        
        registerButton.setTitleColor(UIColor.mainPink(), for: .normal)
        
        let imageView = UIImageView(image: UIImage(named: "background"))
        view.insertSubview(imageView, at: 0)
        self.textfieldCustom()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        animate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        userTextfield.text = ""
        passwordTextfield.text = ""
        self.loginButton.transform = .identity
        self.loginButton.setTitle("Log In", for: .normal)
        
    }
    
    func verifiedData(){
        if formulario.isValidLogin() == true {
            loginButton.isUserInteractionEnabled = true
            loginButton.alpha = 1
        }
    }
    
    func textfieldCustom(){
        userTextfield.delegate = self
        passwordTextfield.delegate = self
        loginButton.isUserInteractionEnabled = true
        loginButton.alpha = 0.5
    }
    
    func animate() {
        userTextfield.frame.origin = CGPoint(x: 0 - userTextfield.frame.size.width, y: userTextfield.frame.origin.y)
        passwordTextfield.frame.origin = CGPoint(x: 0 - passwordTextfield.frame.size.width, y: passwordTextfield.frame.origin.y)
        loginLabel.frame.origin.y = view.frame.size.height
        loginButton.alpha = 0.0
        registerButton.alpha = 0.0
        
        UIView.animate(withDuration: 3.0) {
            self.userTextfield.center.x = self.view.center.x
            self.passwordTextfield.center.x = self.view.center.x
        }
        
        UIView.animate(withDuration: 3.0) {
            self.loginButton.alpha = 1.0
            self.registerButton.alpha = 1.0
        }
        
        UIView.animate(withDuration: 3.0) {
            self.loginLabel.frame.origin.y = 100.0
        }

    }
    
    func showUserView() {
        let vc = UserProfileRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func logIn(_ sender: UIButton) {
        sender.setTitle("Loading...", for: .normal)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 6.0, options: [.autoreverse, .repeat], animations: {
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }, completion: nil)
        self.presenter?.doLogin(parametros: formulario)
    }
    
    @IBAction func register(_ sender: Any) {
        let vc = RegisterRouter.createModule()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Ups!", message: "Hubo un error en tu inicio de sesión. Inténtalo más tarde", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
            UIView.animate(withDuration: 1.0, animations: {
                self.loginButton.transform = .identity
                self.loginButton.setTitle("Log In", for: .normal)
            })
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func didDissmiss() {
    }

}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userTextfield{
            formulario.user = userTextfield.text
        } else if textField == passwordTextfield{
            formulario.password = textField.text
        }
    }
}


