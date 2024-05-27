//
//  UIViewController + Extension.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit

extension UIViewController {

    func showAlert(title: String) {
        
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert)
        
       
        let ok = UIAlertAction(title: "확인", style: .default)
 
        alert.addAction(ok)
        
        present(alert, animated: true)
 
    }
    
    

}
