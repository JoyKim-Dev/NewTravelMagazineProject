//
//  ChatRoomViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 6/3/24.
//

import UIKit

class ChatRoomViewController: UIViewController {

    @IBOutlet var chatTextField: UITextField!
    
    @IBOutlet var chatRoomTableView: UITableView!
    
    var data: ChatRoom?
    var list = ChatList.mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBarButtonItem()
        configureTableView()
        navigationItem.title = data?.chatroomName
        
    }
    
}

extension ChatRoomViewController {
    
    func configureBarButtonItem() {
        let item = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = item
    }
                                   
@objc func backButtonTapped() {
    navigationController?.popViewController(animated: true)
}
 
    func configureTableView() {
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        let xibWithoutImg = UINib(nibName: ChatRoomMessageTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(xibWithoutImg, forCellReuseIdentifier: ChatRoomMessageTableViewCell.identifier)
        
        let xibWithImg = UINib(nibName: ChatRoomMessageWithImageTableViewCell.identifier, bundle: nil)
        chatRoomTableView.register(xibWithImg, forCellReuseIdentifier: ChatRoomMessageWithImageTableViewCell.identifier)
        chatRoomTableView.rowHeight =  UITableView.automaticDimension
            
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if data?.chatList[indexPath.row].user == .user {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomMessageTableViewCell.identifier, for: indexPath) as! ChatRoomMessageTableViewCell
//            let otherCellData = list[indexPath.row]
            cell.configureCell(data!, indexPath: indexPath)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomMessageWithImageTableViewCell.identifier, for: indexPath) as! ChatRoomMessageWithImageTableViewCell
            
            //let userCellData = list[indexPath.row]
            cell.configureCell(data!, indexPath: indexPath)
            
            return cell
        }
        
        
    }
    
    
}
