//
//  mapViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/30/24.
//

import UIKit

import CoreLocation
import MapKit
import SnapKit

class MapViewController: UIViewController {
    @IBOutlet var mapTextField: UITextField!
    @IBOutlet var mapView: MKMapView!

    let locationBtn = UIButton()
    // 위치매니저: 위치에 대한 대부분을 담당함(notification center처럼)
    let locationManager = CLLocationManager()
    
    var category = ["전체보기","한식", "중식", "일식", "양식", "경양식", "분식"]
    var list = RestaurantList.restaurantArray
    let defaultRegion = CLLocationCoordinate2D(latitude: 37.5176577, longitude: 126.8864088)
    let picker = UIPickerView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configureUI()
    }
}

extension MapViewController {
    
    func configHierarchy() {

        view.addSubview(locationBtn)
    }
    
    func configLayout() {
        
        locationBtn.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.1)
            make.height.equalTo(locationBtn.snp.width)
            make.bottom.equalTo(mapView).inset(40)
            make.leading.equalTo(mapView).inset(20)
        }
    }
    
    func configureUI() {
        
        // delegate 처리
        picker.delegate = self
        picker.dataSource = self
        locationManager.delegate = self
        
        // pickerView를 inpuView에 연결
        mapTextField.inputView = picker
        
        // 텍스트필드 설정
        mapTextField.attributedPlaceholder = NSAttributedString(string: "음식 카테고리를 선택하세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
        navigationItem.title = "음식점 지도"
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backBtnTapped))
        
        locationBtn.setImage(UIImage(systemName: "mappin.and.ellipse.circle"), for: .normal)
        locationBtn.contentHorizontalAlignment = .fill
        locationBtn.contentVerticalAlignment = .fill
        locationBtn.tintColor = .red
        locationBtn.addTarget(self, action: #selector(locationBtnTapped), for: .touchUpInside)
    }
    
    func mapAnnotation(center: CLLocationCoordinate2D) {
        
        // 기준 region 설정 - 안해두면 annotation 잘 안보임.
//        let mainRegion = CLLocationCoordinate2D(latitude: list[1].latitude, longitude: list[1].longitude)
//        mapView.region = MKCoordinateRegion(center: mainRegion, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let userRegion = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        
        mapView.setRegion(userRegion, animated: true)
        
        addAnotation(for: list)
        
    }
    func addAnotation(for restaurantArray: [Restaurant]) {
        
        var annotationList:[MKPointAnnotation] = []
        //일단 기존 것 있다면 전체 삭제
        mapView.removeAnnotations(mapView.annotations)
  
        for i in restaurantArray {
            // 핀 생성
            let annotation = MKPointAnnotation()
            // 핀 위치 설정
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            // 핀 타이틀 설정
            annotation.title = i.name
            // 핀 배열에 추가
            annotationList.append(annotation)
            print("Adding annotation for: \(i.name)")
        }
        mapView.addAnnotations(annotationList)
    }
    
    // 1. iOS 시스템 권한 상태 확인 - yes? 위치접근요청 - no? 시스템 권한 설정 alert
    func checkDeviceLocationAuthorization() {
        //타입메서드 호출이라 class명
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization()
            print("위치서비스 켜져 있음")
        } else {
            let alert = UIAlertController(
                title: "디바이스의 위치서비스 설정이 비활성화 되어 있습니다.",
                message: "설정 > 개인정보 보호 및 보안 탭에서 위치 서비스를 켜주세요",
                preferredStyle: .alert)
            
            let setting = UIAlertAction(title: "설정", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(cancel)
            alert.addAction(setting)
            
            present(alert, animated: true)
            mapAnnotation(center: defaultRegion)
        }
    }
    func checkCurrentLocationAuthorization() {
       
        var status: CLAuthorizationStatus
        
        // 버전이 나뉘어져서 두 조건으로 status 확인
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
            print("status 확인")
        } else {
            status = CLLocationManager.authorizationStatus()
            print("status 확인")
        }
        // status 분기처리
        switch status {
        case .notDetermined:
            print("이 권한 상태에서만 권한 문구를 띄울 수 있음.")
            // 아직 권한 설정 안한 사람 -> 권한 요청 문구 띄워주기
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //info.plist에 이걸로 설정해뒀음. 앱 사용중에만 위치 접근 허용
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            print("위치 정보 알려달라고 로직 구성 가능")
            // 원하던 위치 접근 권한 받음! -> 이제 위치 업데이트 시작해줘~!
            locationManager.startUpdatingLocation()
            print("위치 찾기 시작해줘")
        case .denied:
            print("iOS 설정 창으로 이동하라는 얼럿 띄워주기")
            mapAnnotation(center: defaultRegion)
            // 디바이스 전체 설정은 켜져 있지만 이 앱의 위치 권한은 거절했음. 다시 키도록 앱 위치 권한측으로 이동 권유 알람 띄우기
            let alert = UIAlertController(
                title: "앱의 위치서비스 설정이 비활성화 되어 있습니다.",
                message: "설정 > 개인정보 보호 및 보안 탭 > Travel Magazine 탭에서 위치 서비스를 켜주세요",
                preferredStyle: .alert)
            
            let setting = UIAlertAction(title: "설정", style: .default) { _ in
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            
            alert.addAction(cancel)
            alert.addAction(setting)
            
            present(alert, animated: true)
        default:
            print("예외상황발생")
            
        }
            
        }
   
    @objc func backBtnTapped() {
        dismiss(animated: true)
    }
    // 1. iOS 시스템 권한 상태 확인 - yes? 위치접근요청 - no? 시스템 권한 설정 alert
    @objc func locationBtnTapped() {
        print(#function)
        checkDeviceLocationAuthorization()
    }
}

// 피커뷰 설정
extension MapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return category.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //전체 annotation 보이다가 특정 row 선택하면 그 카테고리에 맞는 annotation만 보이게 구현 예정
        mapTextField.resignFirstResponder()
        var categoryList:[Restaurant] = []
        
        if category[row] == "전체보기" {
            addAnotation(for: list)
        } else {
            for i in list {
                if i.category == category[row] {
                    categoryList.append(i)
                }
            }
            addAnotation(for: categoryList)
        }
    }
}
// location delegate 프로토콜
extension MapViewController: CLLocationManagerDelegate {
    
    // 위치를 가져오기 성공한 경우... 위치 업데이트 위해 코드 구성 따라 여러번 호출 가능. 원하는 시점에 호출 그만하라고 해줘야함.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            mapAnnotation(center: coordinate)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    // 위치 가져오기 실패한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        mapAnnotation(center: defaultRegion)
    }
    
    // 사용자 권한 상태 변경되면 호출 for iOS14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function, "iOS14+")
        checkDeviceLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function, "iOS14-")
    }
    
}
