//
//  ProfileViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit

class ChatViewController: UIViewController {

    @IBOutlet var chatSearchBar: UISearchBar!
    @IBOutlet var chatTableView: UITableView!
    
    var list = ChatList.mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTableView()
        
    }
}

extension ChatViewController {
    
    func configureUI() {
        
        configureView("TRAVEL TALK")
        chatSearchBar.placeholder = "친구 이름을 검색해보세요"
        chatSearchBar.delegate = self
    }
    
    func configureTableView() {
        
        chatTableView.delegate = self
        chatTableView.dataSource = self
        let xib = UINib(nibName: RecentChatMessageTableViewCell.identifier, bundle: nil)
        chatTableView.register(xib, forCellReuseIdentifier: RecentChatMessageTableViewCell.identifier)
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.separatorColor = .none
    }
    
 
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecentChatMessageTableViewCell.identifier , for: indexPath) as! RecentChatMessageTableViewCell
        let data = list[indexPath.row]
        cell.configureCell(data)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: ChatRoomViewController.identifier) as! ChatRoomViewController
        
        vc.data = list[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ChatViewController: UISearchBarDelegate {
    
    
}
