//
//  ViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 07/04/23.
//

import UIKit
import FirebaseAuth
import NVActivityIndicatorView

protocol LoginDelegate{
    func login(userText: String, passText:String)
    func register(userText: String, passText:String)
}

class ViewController: UIViewController {
    
    var dataController: DataController!
    let loader:NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: .ballClipRotateMultiple, color: .yellow, padding: 150)
        indicator.backgroundColor = .black.withAlphaComponent(0.4)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        return indicator
    }()
    
    @IBOutlet weak var loginbuttonoutlet: UIButton!
    
    @IBOutlet weak var registerbuttonoutlet: UIButton!
    
    @IBAction func loginActionbutton(_ sender: Any) {
        presentSignInModal(false)
    }
    
    @IBAction func registerActionbutton(_ sender: Any) {
        presentSignInModal(true)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configload(view)
        loader.startAnimating()
        if Auth.auth().currentUser != nil {
            completelogin()
        }else{
            if loader.isAnimating {
                loader.stopAnimating()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.loader.isAnimating {
            self.loader.stopAnimating()
        }
    }
    
    func configload(_ view: UIView){
        view.addSubview(loader)
        
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            loader.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            loader.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
        ])
        
        loader.bringSubviewToFront(view)
    }
    
    func completelogin(){
        
        DispatchQueue.main.async {
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "navigationcontroller") as! UINavigationController
            
            let rootViewController = controller.topViewController as! UITabBarController
            let homeViewController = rootViewController.viewControllers?.first as! HomeViewController
            
            homeViewController.dataController = self.dataController
            
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    private func presentSignInModal(_ isRegister:Bool){
        let singIn = (self.storyboard?.instantiateViewController(withIdentifier: "formSigninStoryboard")) as! SingInViewController
        
        singIn.isRegister = isRegister
        singIn.logindelegate = self
        
        let nav = UINavigationController(rootViewController: singIn)
        nav.modalPresentationStyle = .pageSheet
        
        if let sheet = nav.sheetPresentationController{
            sheet.detents = [.medium(), .large()]
        }
        present(nav, animated: true, completion: nil)
    }
    
    
    


}

extension ViewController: LoginDelegate{
    
    func login(userText: String, passText:String){
        
        loader.startAnimating()
        
        Auth.auth().signIn(withEmail: userText, password: passText){[self](user, error) in
            if error != nil{
                dispatchAlert(nil, message: "Falha ao logar")
            }
            completelogin()
        }
    }
    
    func register(userText: String, passText:String){
        
        loader.startAnimating()
        
        Auth.auth().createUser(withEmail: userText, password: passText, completion: { [self] (user, error: Error?) in
        
            if let err = error{
                print("Erro:", err)
                print("E-mail:", userText)
                
                self.dispatchAlert("Error", message: "\(err) com o e-mail \(userText)")
                return
            }
            print("Sucesso userId:", user?.user.uid ?? "")
            completelogin()
        
        })
    }
    
    
}

