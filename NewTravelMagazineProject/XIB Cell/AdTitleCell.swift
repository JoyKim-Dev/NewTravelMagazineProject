//
//  AdTitleCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit

class AdTitleCell: UITableViewCell {

    // 셀 identifier 타이포를 줄이기 위해 static property로 생성하여 재사용
    static let identifier = "AdTitleCell"
    
    @IBOutlet var adTitleLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        print(#function)

        adTitleLabel.font = .boldSystemFont(ofSize: 20)
        adTitleLabel.backgroundColor = .gray
        
        adLabel.font = .systemFont(ofSize: 15)
        adLabel.backgroundColor = .lightGray.withAlphaComponent(0.2)
        adLabel.textAlignment = .center
        adLabel.layer.cornerRadius = 4
    
    }
    
}
