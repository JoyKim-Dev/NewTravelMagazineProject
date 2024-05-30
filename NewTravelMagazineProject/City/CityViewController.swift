//
//  CityViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/27/24.
//

import UIKit
import Kingfisher

class CityViewController: UIViewController,  UISearchBarDelegate {
    
    @IBOutlet var citySearchBar: UISearchBar!
    @IBOutlet var cityTableView: UITableView!
    
    var list = TravelInfo.travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView("TRAVEL")
        configureTablelView()
        
    }
    
    @objc func likeBtnTapped(sender: UIButton) {
        list[sender.tag].like?.toggle()
        cityTableView.reloadRows(at:[IndexPath(row: sender.tag, section: 0)], with: .automatic)
        
    }

    // 모달화면 내려주기 구현
    @objc func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: UI설정
extension CityViewController {
    
    func configureTablelView() {
        citySearchBar.placeholder = "가고 싶은 곳을 검색해보세요"
        citySearchBar.delegate = self
        cityTableView.delegate = self
        cityTableView.dataSource = self
        cityTableView.rowHeight = 140
        
        // 셀 두 가지 등록 with static으로 선언한 identifier
        let xibOne = UINib(nibName: SmallImageCell.identifier, bundle: nil)
        cityTableView.register(xibOne, forCellReuseIdentifier: SmallImageCell.identifier)
        
        let xibTwo = UINib(nibName: AdTitleCell.identifier, bundle: nil)
        cityTableView.register(xibTwo, forCellReuseIdentifier: AdTitleCell.identifier)
        
        //연결된 화면의 바버튼 아이템(뒤로가기) 타이틀 변경 - 이걸 해줘야 show 방식으로 전환된 화면의 백버튼 타이틀이 변경됨.
        let backBarButtonItem = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem  = backBarButtonItem
        
    }
}

// MARK: TableView 프로토콜 설정
extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    // 셀 갯수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    // 셀 구성 - 두가지 xib 셀 이용하여 조건에 맞춰 띄워주기
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
 
    // 셀 클릭 화면전환
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let data = list[indexPath.row]
        
        guard let ad = data.ad else {
            return
        }
        
        if ad {
            // 스토리보드 연결 - cityViewController는 이미 City storyboard와 연결되어 있고, 화면 전환할 뷰컨씬은 동일한 스토리보드에 들어 잇어서 아래 코드 변경.
//            let sb = UIStoryboard(name: "City", bundle: nil)
            
            // 스토리보드 내부에서 보여줄 화면 지정
            let vc = storyboard?.instantiateViewController(withIdentifier: detailAdViewController.identifier) as! detailAdViewController
            
            // 백버튼 커스텀 -  주의! 네비게이션 컨트롤러 다시 연결하기 전에 진행해야함.
            // 네비게이션 백버튼 타이틀 넣어 생성하고 누르면 내려가게 액션 추가.
            let dismissButton = UIBarButtonItem(title: "뒤로가기", style: .plain, target: self, action: #selector(dismissModal))
            vc.navigationItem.leftBarButtonItem = dismissButton

            // 네비게이션컨트롤러 연결
            let nav = UINavigationController(rootViewController: vc)
            // 프리젠테이션 스타일 (전체화면) 설정
            nav.modalPresentationStyle = .fullScreen
//            nav.modalTransitionStyle = .flipHorizontal
           
            // 다음 화면에 전달해줄 데이터 설정
            vc.data = data
            
            //네비게이션바 있는 present 모달 방식으로 띄워주기
            present(nav, animated: true)

        } else {
            
            // 스토리보드 연결
//            let sb = UIStoryboard(name: "City", bundle: nil)
            
            // 스토리보드 내부에서 보여줄 화면 지정
            let vc = storyboard?.instantiateViewController(withIdentifier: detailCityViewController.identifier) as! detailCityViewController
            
            // 다음 화면에 전달해줄 데이터 설정
            
            vc.data = data
            
            // 네비게이션바 있는 show 푸시 스타일로 띄워주기
            navigationController?.pushViewController(vc, animated: true)
            
            //네비게이션바백버튼 살아 있어서 추가 구현 안함
        }

    }
}

