//
//  CityViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class CityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var citySearchBar: UISearchBar!
    @IBOutlet var cityTableView: UITableView!
    
    var list = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("TRAVEL")
        citySearchBar.placeholder = "가고 싶은 곳을 검색해보세요"
        citySearchBar.delegate = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 140
        
        // 셀 등록
        let xibOne = UINib(nibName: SmallImageCell.identifier, bundle: nil)
        cityTableView.register(xibOne, forCellReuseIdentifier: SmallImageCell.identifier)
        
        let xibTwo = UINib(nibName: AdTitleCell.identifier, bundle: nil)
        cityTableView.register(xibTwo, forCellReuseIdentifier: AdTitleCell.identifier)
    }
    
    @objc func likeBtnTapped(sender: UIButton) {
        list[sender.tag].like?.toggle()
        cityTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        
        
        if data.ad == true {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTitleCell.identifier, for: indexPath) as! AdTitleCell
            cell.adLabel.text = "AD"
            cell.adTitleLabel.text = data.title
            cell.adTitleLabel.backgroundColor = UIColor.random
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SmallImageCell.identifier, for: indexPath) as! SmallImageCell

            
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            
            cell.configureCell(data: data)
            
            return cell
        }
    }
    
  
}





