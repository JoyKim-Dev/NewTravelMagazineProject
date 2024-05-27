//
//  BigImageCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class BigImageCell: UITableViewCell {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var likeBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }
    
    func configureLayout() {
 
        titleLabel.font = .boldSystemFont(ofSize: 18)
        subtitleLabel.font = .systemFont(ofSize: 15)
        
        contentView.backgroundColor = .white
        mainImageView.layer.cornerRadius = 6
        
        
    }
    
    func configureCell(data:Magazine) {
        
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle

    }
}
