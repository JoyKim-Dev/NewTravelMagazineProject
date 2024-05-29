//
//  TravelMainViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

//별 : 코스모스 라이브러리 사용

import UIKit
import Kingfisher

class TravelMainViewController: UIViewController {
    
    @IBOutlet var travelSearchBar: UISearchBar!
    @IBOutlet var travelTableView: UITableView!
    
    var list = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureTablelView()
       
    }
    
    @objc func likeBtnTapped(sender: UIButton) {
        
        list[sender.tag].like.toggle()
        travelTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
    }
    
}


// MARK: UI설정

// 뷰컨의 뷰디드로드에 들어있던 설정을 익스텐션으로 따로 빼냄

extension TravelMainViewController {
    
    func configureTablelView() {
        // 필수
        travelSearchBar.delegate = self
        travelTableView.delegate = self
        travelTableView.dataSource = self
        travelTableView.rowHeight = 450
        
        let xib = UINib(nibName: BigImageCell.identifier, bundle: nil)
        travelTableView.register(xib, forCellReuseIdentifier: BigImageCell.identifier)
    }
    
    
}

extension TravelMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BigImageCell.identifier, for: indexPath) as! BigImageCell
        
        let data = list[indexPath.row]
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        
        cell.configureCell(data: data)

        return cell
    }
}
    
    extension TravelMainViewController:  UISearchBarDelegate {
        
        
        func dismissKeyboard(_ searchBar: UISearchBar) {
            travelSearchBar.resignFirstResponder()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            dismissKeyboard(searchBar)
        }
        
        
        
    }

