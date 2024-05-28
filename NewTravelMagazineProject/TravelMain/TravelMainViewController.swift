//
//  TravelMainViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

//별 : 코스모스 라이브러리 사용 

import UIKit
import Kingfisher

class TravelMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var travelSearchBar: UISearchBar!
    @IBOutlet var travelTableView: UITableView!
    
    var list = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 필수
        travelSearchBar.delegate = self
        travelTableView.delegate = self
        travelTableView.dataSource = self
        travelTableView.rowHeight = 450
        let xib = UINib(nibName: "BigImageCell", bundle: nil)
        travelTableView.register(xib, forCellReuseIdentifier: "BigImageCell")
    }
        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return list.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "BigImageCell", for: indexPath) as! BigImageCell
            let data = list[indexPath.row]
            
            // 좋아요버튼 채우기
            let heartName = data.like ? "heart.fill" : "heart"
            let heartImage = UIImage(systemName: heartName)
            cell.likeBtn.setImage(heartImage , for: .normal)
            cell.likeBtn.tintColor = .black
            
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            
            let url = URL(string: data.image)
            cell.mainImageView.kf.setImage(with: url, placeholder: UIImage(systemName:"network.slash"))
            cell.mainImageView.contentMode = .scaleAspectFill
            
            //게시일자
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yy년 MM월 dd일 HH시"
            cell.dateLabel.text = dateFormatter.string(from: Date())
            cell.dateLabel.font = .systemFont(ofSize: 10)
            cell.dateLabel.textColor = .gray
            
            cell.configureCell(data: list[indexPath.row])
            
            return cell
        }
        
        @objc func likeBtnTapped(sender: UIButton) {
            
            list[sender.tag].like.toggle()
            travelTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        }
    }

