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
    var filteredList: [Magazine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       configureTablelView()
       
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
        filteredList = list
        
        //이벤트 감지할 수 있게 클리어 버튼 대신 캔슬 버튼 보이게 할 것. 캔슬 버튼은 보이지 않다가 서치바 입력 시작 시 보여지게 설정.
        travelSearchBar.searchTextField.clearButtonMode = .never

       
        
        let xib = UINib(nibName: BigImageCell.identifier, bundle: nil)
        travelTableView.register(xib, forCellReuseIdentifier: BigImageCell.identifier)
    }
    
    
    @objc func likeBtnTapped(sender: UIButton) {
        
        list[sender.tag].like.toggle()
        travelTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
    }
    
}


// MARK: tableView

extension TravelMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BigImageCell.identifier, for: indexPath) as! BigImageCell
        
        let data = filteredList[indexPath.row]
        
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        
        cell.configureCell(data: data)

        return cell
    }
}
    

// MARK: searchBar

extension TravelMainViewController:  UISearchBarDelegate {
    
 
    // 검색 시작하면 캔슬 버튼 활성화.
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        travelSearchBar.showsCancelButton = true
        travelSearchBar.becomeFirstResponder()
    }
    
    // 서치바 검색 기능: 검색한 내용이 레이블 내용에 포함되어 있는지 확인하고 띄워주기.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var searchList: [Magazine] = []
     
        for i in list {
            if i.title.contains(searchBar.text!) ||
                i.subtitle.contains(searchBar.text!) {
                
                searchList.append(i)
            }
        }
        filteredList = searchList
        travelTableView.reloadData()
    }
    
 // 캔슬 버튼 클릭되면 텍스트 다 지우고, 리스트 전체보기로 전환
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        travelSearchBar.resignFirstResponder()
        travelSearchBar.text = ""
        travelSearchBar.showsCancelButton = false
        filteredList = list
        travelTableView.reloadData()
    }

    
}

