//
//  ProfileViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 17/04/23.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBAction func logout(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            gotoLogin()
        }catch let logerror{
            dispatchAlert("Erro ao Sair", message: "Não conseguimos efetuar seu logout!")
            print("ERRO de SAIDA:", logerror.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func gotoLogin(){
        let loginVc = self.storyboard?.instantiateViewController(withIdentifier: "loginStoryboard") as! ViewController
        
        self.present(loginVc, animated: true, completion: nil)
    }

}
