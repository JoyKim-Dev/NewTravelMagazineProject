//
//  RestaurantViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // 테이블뷰컨 사용하지 않기 때문에 테이블뷰 연결해주기
    @IBOutlet var restaurantSearchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    
    @IBOutlet var filterBtnCollection: [UIButton]!
    @IBOutlet var filterBtnLabel: UILabel!
    
    
    
    //  RestaurantList의 property에 static 키워드를 붙여줘서 인스턴스 생성 없이도 접근 가능.
    var list = RestaurantList.restaurantArray
    var filteredList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //extension 활용
        configureView("RESTAURANT")
        restaurantSearchBar.placeholder = "먹고 싶은 메뉴를 검색해보세요"
        restaurantSearchBar.delegate = self
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = 140
        
        // xib 셀 연결
        let xib = UINib(nibName: SmallImageCell.identifier, bundle: nil)
        restaurantTableView.register(xib, forCellReuseIdentifier: SmallImageCell.identifier)
        
        configureUI()
        filterBtnSearch()
        
    }
    
    func configureUI() {
        
        designFilterBtnUI()
        filterBtnLabel.font = .boldSystemFont(ofSize: 16)
        filterBtnLabel.text = "추천검색어"
        
    }
    
    // 버튼 UI 설정
    func designFilterBtnUI() {
        filterBtnCollection[0].setTitle("추천메뉴", for: .normal)
        filterBtnCollection[1].setTitle("한식", for: .normal)
        filterBtnCollection[2].setTitle("일식", for: .normal)
        filterBtnCollection[3].setTitle("전체보기", for: .normal)
        
        for btn in filterBtnCollection {
            btn.titleLabel?.font = .boldSystemFont(ofSize: 15)
            btn.setTitleColor(.systemPink, for: .normal)
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.systemPink.cgColor
            btn.layer.cornerRadius = 4
        }
    }
    
    // 서치바 검색 기능
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        var searchList: [Restaurant] = []
        
        for i in list {
            
            if i.name.contains(searchBar.text!) ||
                i.category.contains(searchBar.text!) {
                
                searchList.append(i)
            }
        }
        
        filteredList = searchList
        restaurantTableView.reloadData()
    }
    
    // 버튼 필터링 기능
    func filterBtnSearch() {
        
        for btn in filterBtnCollection {
            btn.addTarget(self, action: #selector(filterBtnTapped), for:.touchUpInside)
        }
    }
    // 버튼 필터링 기능 함수
    @objc func filterBtnTapped(sender:UIButton) {
        var koreanFood: [Restaurant] = []
        var japaneseFood: [Restaurant] = []
        let tag = sender.tag
        
        for i in list {
            if i.category == "한식" {
                koreanFood.append(i)
            } else if i.category == "일식" {
                japaneseFood.append(i)
            }
        }
        
        if tag == 0 {
            filteredList.removeAll()
            filteredList.append(list.randomElement()!)
            print("1번")
        } else if tag == 1 {
            filteredList.removeAll()
            filteredList = koreanFood
            print("2번")
        } else if tag == 2 {
            filteredList.removeAll()
            filteredList = japaneseFood
            print("3번")
        } else {
            filteredList.removeAll()
            filteredList = list
        }
        restaurantTableView.reloadData()
    }
    // 좋아요 버튼 기능 함수
    @objc func likeBtnTapped(sender: UIButton) {
        
        filteredList[sender.tag].like.toggle()
        restaurantTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SmallImageCell.identifier, for: indexPath) as! SmallImageCell
        let data = filteredList[indexPath.row]
        
        // 좋아요 버튼 기능
        cell.likeBtn.tag = indexPath.row
        cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
        
        cell.configureCell(data: data )
        
        return cell
    }
}

