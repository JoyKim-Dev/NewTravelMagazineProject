//
//  SmallImageCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class SmallImageCell: UITableViewCell {

    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var phonenumberLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var likeBtn: UIButton!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureLayout()
    }

    func configureLayout() {
        print(#function)

        titleLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.font = .boldSystemFont(ofSize: 15)
        descriptionLabel.textColor = .systemPink
        phonenumberLabel.font = .systemFont(ofSize: 13)
        addressLabel.font = .systemFont(ofSize: 13)
        mainImageView.layer.cornerRadius = 4
    }
    
    
    func configureCell(data:Restaurant) {
        
        titleLabel.text = data.name
        descriptionLabel.text = "\(data.category) | \(data.price.formatted())원대"
        phonenumberLabel.text = data.phoneNumber
        addressLabel.text = data.address

    }
    
}
