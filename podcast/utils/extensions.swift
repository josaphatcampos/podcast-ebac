//
//  extensions.swift
//  podcast
//
//  Created by Josaphat Campos Pereira on 09/04/23.
//

import Foundation
import AVFoundation
import UIKit

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

extension UIViewController{
    func dispatchAlert(_ title: String?, message: String, handler: @escaping()->Void = {}){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let dismissAction = UIAlertAction(title: "Fechar", style: .default) { (action)->Void in
            handler()
        }
        
        alert.addAction(dismissAction)
        self.present(alert, animated: true, completion: nil)
    }
}



