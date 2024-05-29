//
//  FavoriteViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit

class PopularCityViewController: UIViewController {
    
    @IBOutlet var popularCitySearchBar: UISearchBar!
    @IBOutlet var popularCityTableView: UITableView!
    
    var list = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView("인기도시")
        configureTablelView()
    }
}


// MARK: UI설정

// 뷰컨의 뷰디드로드에 들어있던 설정을 익스텐션으로 따로 빼냄

extension PopularCityViewController {
    
    func configureTablelView() {
        // 필수
        popularCitySearchBar.delegate = self
        popularCityTableView.delegate = self
        popularCityTableView.dataSource = self
        popularCityTableView.rowHeight = 200
        
        let xib = UINib(nibName: FullImageCell.identifier, bundle: nil)
        popularCityTableView.register(xib, forCellReuseIdentifier: FullImageCell.identifier)
    }
}

extension PopularCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FullImageCell.identifier, for: indexPath) as! FullImageCell
        
        let data = list[indexPath.row]
        
        cell.configureCell(data: data)
        
        return cell
    }
}

extension PopularCityViewController:  UISearchBarDelegate {
    
    func dismissKeyboard(_ searchBar: UISearchBar) {
        popularCitySearchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard(searchBar)
    }
    
    
    
}




