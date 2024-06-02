//
//  FullImageTableViewCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/29/24.
//

import UIKit
import Kingfisher

class FullImageCell: UITableViewCell {
    
    //static let identifier = "FullImageCell"
    
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
        
    }
    
    func configureLayout() {
        print(#function)
        
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        subtitleLabel.textColor = .white
        subtitleLabel.font = .systemFont(ofSize: 18)
        
        mainImageView.layer.cornerRadius = 20
        // 특정 모서리만 둥글리기
        mainImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
    }
    
    
    func configureCell(data: City) {
        
        titleLabel.text = "\(data.city_name) | \(data.city_english_name)"
        subtitleLabel.text = data.city_explain
        
        mainImageView.kf.setImage(with: URL(string: data.city_image),placeholder: UIImage(systemName: "network.slash"))
        mainImageView.contentMode = .scaleAspectFill
        
        
    }
}
