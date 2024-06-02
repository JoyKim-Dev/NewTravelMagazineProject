//
//  mapViewController.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 5/30/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
   // static let identifier = "MapViewController"
    
    var category = ["한식", "중식", "일식", "양식", "경양식", "분식", "전체보기"]
    var list = RestaurantList.restaurantArray
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        mapAnnotation()
        
    }
    
}

extension MapViewController {
    
    func configureUI() {
        
        // delegate 처리
        picker.delegate = self
        
        // pickerView를 inpuViewd에 연결
        mapTextField.inputView = picker
        
        // 텍스트필드 설정
        mapTextField.attributedPlaceholder = NSAttributedString(string: "음식 카테고리를 선택하세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
    }
    
    
    func mapAnnotation() {
        
        // 기준 region 설정 - 안해두면 annotation 잘 안보임.
        let mainRegion = CLLocationCoordinate2D(latitude: list[1].latitude, longitude: list[1].longitude)
        mapView.region = MKCoordinateRegion(center: mainRegion, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        // 식당 맵뷰 annotation 처리
        var annotationArray: [MKAnnotation] = []
        
        for i in list {
            // 핀 생성
            let annotation = MKPointAnnotation()
            // 핀 위치 설정
            annotation.coordinate = CLLocationCoordinate2D(latitude: i.latitude, longitude: i.longitude)
            // 핀 타이틀 설정
            annotation.title = i.name
            // 핀 배열에 추가
            annotationArray.append(annotation)
            print("Adding annotation for: \(i.name)")
        }
        // 맵뷰에 핀 추가
        mapView.addAnnotations(annotationArray)
        
        // print("Annotations added: \(annotationArray)")
    }
}

// 피커뷰 설정
extension MapViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 7
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return category[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //전체 annotation 보이다가 특정 row 선택하면 그 카테고리에 맞는 annotation만 보이게 구현 예정
        mapTextField.resignFirstResponder()
    }
    
    
}
