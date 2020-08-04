//
//  RegisterViewController.swift
//  LogIn
//
//  Created sferea on 03/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import CommonCrypto

class RegisterViewController: UIViewController,RegisterViewControllerProtocol {
    
    var presenter: RegisterPresenterProtocol?

    var formulario = UserEntity(){
        didSet{
            verifiedData()
        }
    }
    
    let registerButton = UIButton()
    lazy var nameTxtFld:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Nombre"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var mailTxtFld:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Correo"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var lastNameTxtFld:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Apellido"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var telTxtFld:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Telefono"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()
    
    lazy var passwordTxtFld:UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.font = UIFont.systemFont(ofSize: 13)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.whileEditing;
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showTxtFlds()
        self.myButton()
        self.textFldDelegates()
    }
    
    func verifiedData(){
        if formulario.isValidCreateAccount() == true {
            registerButton.isUserInteractionEnabled = true
            registerButton.alpha = 1
        }
    }
    
    func myButton(){
        registerButton.isUserInteractionEnabled = false
        registerButton.alpha = 0.5
        registerButton.frame = CGRect(x: self.view.center.x - ((self.view.frame.size.width * 0.5)/2) , y: self.view.center.y * 1.75, width: self.view.frame.size.width * 0.50, height: 40)
        registerButton.backgroundColor = UIColor.mainPink()
        registerButton.setTitle("Register", for: .normal)
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        self.view.addSubview(registerButton)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        self.presenter?.sendCreateAccount(parametros: formulario)
    }
    
    func showTxtFlds(){
        self.view.addSubview(nameTxtFld)
        NSLayoutConstraint(item: nameTxtFld, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: nameTxtFld, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.35, constant: 0).isActive = true
        NSLayoutConstraint(item: nameTxtFld, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: 0).isActive = true
        
        self.view.addSubview(lastNameTxtFld)
        NSLayoutConstraint(item: lastNameTxtFld, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: lastNameTxtFld, attribute: .top, relatedBy: .equal, toItem: self.nameTxtFld, attribute: .centerY, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: lastNameTxtFld, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: 0).isActive = true
        
        self.view.addSubview(mailTxtFld)
        NSLayoutConstraint(item: mailTxtFld, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: mailTxtFld, attribute: .top, relatedBy: .equal, toItem: self.lastNameTxtFld, attribute: .centerY, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: mailTxtFld, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: 0).isActive = true
        
        self.view.addSubview(telTxtFld)
        NSLayoutConstraint(item: telTxtFld, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: telTxtFld, attribute: .top, relatedBy: .equal, toItem: self.mailTxtFld, attribute: .centerY, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: telTxtFld, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: 0).isActive = true
        
        self.view.addSubview(passwordTxtFld)
        NSLayoutConstraint(item: passwordTxtFld, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: passwordTxtFld, attribute: .top, relatedBy: .equal, toItem: self.telTxtFld, attribute: .centerY, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: passwordTxtFld, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.75, constant: 0).isActive = true
        self.passwordTxtFld.isSecureTextEntry = true
    }
    
    func textFldDelegates(){
        nameTxtFld.delegate = self
        lastNameTxtFld.delegate = self
        mailTxtFld.delegate = self
        telTxtFld.delegate = self
        passwordTxtFld.delegate = self
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == nameTxtFld{
            formulario.name = textField.text
        } else if textField == lastNameTxtFld{
            formulario.lastName = textField.text
        } else if textField == mailTxtFld{
            formulario.email = textField.text
        } else if textField == telTxtFld{
            formulario.phoneNumber = textField.text 
        } else if textField == passwordTxtFld{
            formulario.password = textField.text
        }
    }
    
}
