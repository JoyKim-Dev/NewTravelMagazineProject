//
//  detailCityViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/29/24.
//

import UIKit
import Kingfisher

class detailCityViewController: UIViewController {

    @IBOutlet var cityDetailImageView: UIImageView!
    @IBOutlet var cityDetailTitleLabel: UILabel!
    @IBOutlet var citySaveAndGradeLabel: UILabel!
    @IBOutlet var cityDetailDescriptionLabel: UILabel!
    @IBOutlet var detailCitySaveBtn: UIButton!
    
    static let identifier = "detailCityViewController"
    
    // Pass Data 1. 데이터를 받을 공간(property) 생성
    // 2. 데이터를 받아올 이전 화면에서 데이터 설정
    // 3. 데이터를 받아오기
    
    var data: Travel?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView("관광지상세")
        configureUI()

    }
}

extension detailCityViewController {
    
    func configureUI() {
        
        setLabelUI()
        setBtnUI()
        setImageUI() 
       
    }
    
    func setLabelUI() {
        cityDetailTitleLabel.text = data?.title
        citySaveAndGradeLabel.text = data?.saveAndGrade
        cityDetailDescriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }
    
    func setBtnUI() {
        detailCitySaveBtn.setTitle("찜하기", for: .normal)
        detailCitySaveBtn.layer.cornerRadius = 4
        detailCitySaveBtn.backgroundColor = .systemPink.withAlphaComponent(0.2)
        detailCitySaveBtn.setTitleColor(.blue, for: .normal)
        detailCitySaveBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .heavy)
    }
    
    func setImageUI() {
        cityDetailImageView.kf.setImage(with: URL(string: data?.travel_image ?? "\(UIImage(systemName: "star"))"))
        cityDetailImageView.contentMode = .scaleAspectFill
    }
    
}
