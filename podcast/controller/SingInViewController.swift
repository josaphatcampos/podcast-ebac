//
//  SingInViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 17/04/23.
//

import UIKit
import FirebaseAuth

class SingInViewController: UIViewController {
    
    var isRegister:Bool!
    var logindelegate:LoginDelegate!
    
    @IBOutlet weak var userinput: UITextField!
    
    @IBOutlet weak var passwordinput: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func btnAction(_ sender: Any) {
        
        if isRegister {
            register()
        }else{
            login()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isRegister! {
            
            btn.setTitle("Registrar", for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func validateTextField() -> Bool{
        return !(userinput.text?.isEmpty ?? true) && !(passwordinput.text?.isEmpty ?? true)
    }
    
    func login(){
        if validateTextField() {
            guard let email = userinput.text, !email.isEmpty else{return}
            guard let password = passwordinput.text, !password.isEmpty else{return}
            
            self.dismiss(animated: true)
            logindelegate.login(userText: email, passText: password)
            
            
        }else{
            dispatchAlert(nil, message: "Usuário e/ou senha não preenchidos.")
        }
    }
    
    func register(){
        guard let email = userinput.text, !email.isEmpty else{
            return
        }
        guard let password = passwordinput.text, !password.isEmpty else{
            return
        }
        
        if validateTextField() {
            guard let email = userinput.text, !email.isEmpty else{return}
            guard let password = passwordinput.text, !password.isEmpty else{return}
        
            self.dismiss(animated: true)
            logindelegate.register(userText: email, passText: password)
        }else{
            dispatchAlert(nil, message: "Usuário e/ou senha não preenchidos.")
            
        }
    }

}
