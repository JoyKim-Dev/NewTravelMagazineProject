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
    
    var list = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citySearchBar.placeholder = "먹고 싶은 메뉴를 검색해보세요"
        citySearchBar.delegate = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 140
        
        let xibOne = UINib(nibName: "SmallImageCell", bundle: nil)
        cityTableView.register(xibOne, forCellReuseIdentifier: "SmallImageCell")
        
        let xibTwo = UINib(nibName: "AdTitleCell", bundle: nil)
        cityTableView.register(xibTwo, forCellReuseIdentifier: "AdTitleCell")
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        
        
        if data.ad == true {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTitleCell", for: indexPath) as! AdTitleCell
            cell.adLabel.text = "AD"
            cell.adTitleLabel.text = data.title
            cell.adTitleLabel.backgroundColor = UIColor.random
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SmallImageCell", for: indexPath) as! SmallImageCell
            
            guard let save = data.save else {
                print("없습니다.")
                return cell
            }
            
            guard let grade = data.grade else {
                print("없습니다.")
                return cell
            }
            
            guard let image = data.image else {
                print("없습니다.")
                return cell
            }
            
            guard let like = data.like else {
                print("없습니다.")
                return cell
            }
            
            cell.titleLabel.text = data.title
            cell.descriptionLabel.text = "찜 \(save)개 | 평점 \(grade) "
            cell.descriptionLabel.font = .systemFont(ofSize: 14)
            cell.descriptionLabel.textColor = .black
            cell.phonenumberLabel.text = " "
            
            cell.addressLabel.text = data.description
            cell.addressLabel.font = .systemFont(ofSize: 12)
            
            cell.mainImageView.kf.setImage(with: URL(string: image))
            cell.mainImageView.contentMode = .scaleAspectFill
            cell.mainImageView.layer.cornerRadius = 5
            
            let heartName = like ? "heart.fill" : "heart"
            let heartImage = UIImage(systemName: heartName)
            cell.likeBtn.setImage(heartImage , for: .normal)
            cell.likeBtn.tintColor = .black
            
            cell.likeBtn.tag = indexPath.row
            cell.likeBtn.addTarget(self, action: #selector(likeBtnTapped), for: .touchUpInside)
            
            return cell
        }
    }
    
    @objc func likeBtnTapped(sender: UIButton) {

        
        list[sender.tag].like?.toggle()
        cityTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
    }
}
    
    
    
    
    
