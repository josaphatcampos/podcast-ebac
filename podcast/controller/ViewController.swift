//
//  ViewController.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 07/04/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var loginbuttonoutlet: UIButton!
    
    @IBOutlet weak var registerbuttonoutlet: UIButton!
    
    @IBAction func loginActionbutton(_ sender: Any) {
        
        completelogin()
        
    }
    
    @IBAction func registerActionbutton(_ sender: Any) {
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func completelogin(){
        DispatchQueue.main.async {
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "tabbarstoryboard") as! UITabBarController
            self.present(controller, animated: true, completion: nil)
        }
    }
    


}

