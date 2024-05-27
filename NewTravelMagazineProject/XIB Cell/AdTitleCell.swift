//
//  AdTitleCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit

class AdTitleCell: UITableViewCell {

    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        print(#function)

        adTitleLabel.font = .boldSystemFont(ofSize: 17)
        adLabel.font = .systemFont(ofSize: 13)
        adTitleLabel.backgroundColor = .gray
        adLabel.backgroundColor = .white
       
        
    }
    
}
