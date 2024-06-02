//
//  SmallImageCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class SmallImageCell: UITableViewCell {
    
    // 셀 identifier 타이포를 줄이기 위해 static property로 생성하여 재사용
    //static let identifier = "SmallImageCell"
    
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
    
    // 기본 셀 세팅값
    func configureLayout() {
        print(#function)
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        descriptionLabel.font = .boldSystemFont(ofSize: 15)
        descriptionLabel.textColor = .systemPink
        phonenumberLabel.font = .systemFont(ofSize: 14)
        addressLabel.font = .systemFont(ofSize: 14)
        mainImageView.layer.cornerRadius = 6
    }
    
    
    func configureCell(data:Restaurant) {
        
        // 라벨 텍스트 삽입
        titleLabel.text = data.name
        descriptionLabel.text = data.categoryAndPrice
        phonenumberLabel.text = data.phoneNumber
        addressLabel.text = data.address
        
        // 좋아요 기능 구현
        let heartName = data.like ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartName)
        likeBtn.setImage(heartImage , for: .normal)
        likeBtn.tintColor = .black
        
       
        // 이미지 삽입
        let url = URL(string: data.image)
        mainImageView.kf.setImage(with: url, placeholder: UIImage(systemName:"network.slash"))
        mainImageView.contentMode = .scaleAspectFill
    }
    
    func configureCell(data:Travel) {
        
        titleLabel.text = data.title
        descriptionLabel.text = data.saveAndGrade
        phonenumberLabel.text = " "
        addressLabel.text = data.description

        guard let url = data.travel_image,
        let like = data.like else {
            return
        }
    
        mainImageView.kf.setImage(with: URL(string: url))
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.layer.cornerRadius = 5
        
        let heartName = like ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartName)
        likeBtn.setImage(heartImage , for: .normal)
        likeBtn.tintColor = .black
    }
}
