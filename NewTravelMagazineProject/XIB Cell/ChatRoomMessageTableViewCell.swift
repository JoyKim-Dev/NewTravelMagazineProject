//
//  ChatRoomMessageTableViewCell.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 6/3/24.
//

import UIKit

class ChatRoomMessageTableViewCell: UITableViewCell {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .darkGray
        dateLabel.textAlignment = .left
        
        messageLabel.layer.borderColor = UIColor.lightGray.cgColor
        messageLabel.layer.cornerRadius = 4
        messageLabel.layer.borderWidth = 1
        messageLabel.clipsToBounds = true
    }

    func configureCell(_ cellData: ChatRoom, indexPath: IndexPath) {

        dateLabel.text = cellData.chatList[indexPath.row].date
        messageLabel.text = cellData.chatList[indexPath.row].message
    }
    
}
