//
//  RestaurantViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class RestaurantViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var restaurantSearchBar: UISearchBar!
    @IBOutlet var restaurantTableView: UITableView!
    
    var list = RestaurantList().restaurantArray
    var filteredList: [Restaurant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "RESTAURANT"
        restaurantSearchBar.placeholder = "먹고 싶은 메뉴를 검색해보세요"
        restaurantSearchBar.delegate = self
        restaurantTableView.delegate = self
        restaurantTableView.dataSource = self
        restaurantTableView.rowHeight = 120
        
        let xib = UINib(nibName: "SmallImageCell", bundle: nil)
        restaurantTableView.register(xib, forCellReuseIdentifier: "SmallImageCell")
   
        
        
                let left = UIBarButtonItem(title: "한식", style: .plain, target: self, action: #selector(leftBarBtnClicked))
                let all = UIBarButtonItem(title: "전체보기", style: .plain, target: self, action: #selector(allBarBtnClicked))
        
                navigationItem.leftBarButtonItems = [left, all]
        
                filteredList = list
            }
        
            @objc func leftBarBtnClicked() {
                // list > 반복문 돌면서 > 한식에 해당되는 내용만 찾고 > 리로드 데이터
                var koreanFood: [Restaurant] = []
        
                for item in list {
        
                    if item.category == "한식" {
                        koreanFood.append(item)
                    }
                }
        
                showAlert(title: "한식 버튼을 클릭했습니다.")
                filteredList = koreanFood
                restaurantTableView.reloadData()
            }
        
            @objc func allBarBtnClicked() {
                // list > 반복문 돌면서 > 한식에 해당되는 내용만 찾고 > 리로드 데이터
        
                showAlert(title: "모든 버튼을 클릭했습니다.")
        
                filteredList = list
                restaurantTableView.reloadData()
        
            }
        
            func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
                var searchList: [Restaurant] = []
        
                for item in list {
        
                    // if item.name == searchBar.text 이런 형태 안씀. contain 씀.
        
                    if item.name.contains(searchBar.text!) ||
                        item.category.contains(searchBar.text!) {
        
                        searchList.append(item)
                    }
                }
                filteredList = searchList
                restaurantTableView.reloadData()
            }
        
    @objc func likeBtnTapped(sender: UIButton) {
        
        list[sender.tag].like.toggle()
        restaurantTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filteredList.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallImageCell", for: indexPath) as! SmallImageCell
            let data = list[indexPath.row]
            
            
            let heartName = data.like ? "heart.fill" : "heart"
            let heartImage = UIImage(systemName: heartName)
            cell.likeBtn.setImage(heartImage , for: .normal)
            cell.likeBtn.tintColor = .black
            
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            
            
            let url = URL(string: data.image)
            cell.mainImageView.kf.setImage(with: url, placeholder: UIImage(systemName:"network.slash"))
            cell.mainImageView.contentMode = .scaleAspectFill
            
            cell.configureCell(data: list[indexPath.row])
            
            cell.titleLabel.text = data.name
            cell.descriptionLabel.text = "\(data.category) | \(data.price.formatted())원대"
            cell.phonenumberLabel.text = data.phoneNumber
            cell.addressLabel.text = data.address
            
            return cell
        }
        
        
    }

