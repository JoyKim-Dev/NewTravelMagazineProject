//
//  BigImageCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

// 셀 identifier 타이포를 줄이기 위해 static property로 생성하여 재사용
class BigImageCell: UITableViewCell {
    
    static let identifier = "BigImageCell"
    
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
        contentView.backgroundColor = .white
        
        titleLabel.font = .boldSystemFont(ofSize: 18)
        subtitleLabel.font = .systemFont(ofSize: 15)
        
        mainImageView.layer.cornerRadius = 6
    }
    
    func configureCell(data: Magazine) {
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        
        // 좋아요버튼 채우기
        let heartName = data.like ? "heart.fill" : "heart"
        let heartImage = UIImage(systemName: heartName)
        likeBtn.setImage(heartImage , for: .normal)
        likeBtn.tintColor = .black
        
        let url = URL(string: data.image)
        mainImageView.kf.setImage(with: url, placeholder: UIImage(systemName:"network.slash"))
        mainImageView.contentMode = .scaleAspectFill
        
        //게시일자
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일 HH시"
        dateLabel.text = dateFormatter.string(from: Date())
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .gray
        
    }
    
}
