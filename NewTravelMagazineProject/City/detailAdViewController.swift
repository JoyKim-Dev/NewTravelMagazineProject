//
//  detailAdViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/29/24.
//

import UIKit

class detailAdViewController: UIViewController {

    @IBOutlet var detailAdLabel: UILabel!
    
    static let identifier = "detailAdViewController"
    
    var data: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView("광고상세")
        configureUI()
    }

}

extension detailAdViewController {
    
    func configureUI() {
        
        setLabelUI()
    }
    
    func setLabelUI() {
        detailAdLabel.text = data?.title
        detailAdLabel.contentMode = .center
        detailAdLabel.textAlignment = .center
        detailAdLabel.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        detailAdLabel.layer.cornerRadius = 10
        detailAdLabel.layer.masksToBounds = true
        detailAdLabel.font = .boldSystemFont(ofSize: 20)
    }
}
