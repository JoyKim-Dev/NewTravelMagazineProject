//
//  BaseViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 7/1/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Base", #function)
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        print("Base", #function)
    }
    
    func configureLayout() {
        print("Base", #function)
    }
    func configureView() {
        print("Base", #function)

    }
}
