//
//  UIViewController + Extension.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//
// Extension: 재사용할

import UIKit

extension UIViewController {
    
    //기본 뷰 UI
    
    func configureView(_ title: String) {
        navigationItem.title = title
    }
    
    

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
