//
//  RecentChatMessageTableViewCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 6/3/24.
//

import UIKit

class RecentChatMessageTableViewCell: UITableViewCell {
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var recentMessageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .right
    }

    func configureCell(_ data: ChatRoom) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        dateLabel.text = dateFormatter.string(from: Date())
        
        mainImageView.image = UIImage(named: data.chatroomImage[data.chatroomImage.count - 1])
        recentMessageLabel.text = data.chatList[data.chatList.count - 1].message
        nicknameLabel.text = data.chatList[data.chatList.count - 1].user.rawValue
        
            
        }
        
    }
    

