//
//  ChatRoomMessageWithImageTableViewCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 6/3/24.
//

import UIKit

class ChatRoomMessageWithImageTableViewCell: UITableViewCell {
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
         dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
         dateLabel.textColor = .darkGray
         dateLabel.textAlignment = .right
        
        messageLabel.layer.borderColor = UIColor.lightGray.cgColor
        messageLabel.layer.cornerRadius = 4
        messageLabel.layer.borderWidth = 1
        messageLabel.clipsToBounds = true
    }

    func configureCell(_ cellData: ChatRoom, indexPath: IndexPath) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
        dateLabel.text = cellData.chatList[indexPath.row].date
        
        mainImageView.image = UIImage(named: cellData.chatList[indexPath.row].user.rawValue)
        messageLabel.text = cellData.chatList[indexPath.row].message
        nicknameLabel.text = cellData.chatList[indexPath.row].user.rawValue
    }
    
    
}
