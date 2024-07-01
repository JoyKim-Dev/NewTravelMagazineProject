//
//  NasaUrlSessionVC.swift
//  NewTravelMagazineProject
//
//  Created by Joy Kim on 7/1/24.
//

import UIKit
import SnapKit

class NasaUrlSessionVC: BaseViewController {
    
    // 전역에서 필요한 열거형이 아니라서 클래스 내부에 선언
    enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
         
        static var photo: URL {
            return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
    let imageView = UIImageView()
    let progressView = UIProgressView()
    let requestButton = UIButton()
    
    // 이미지 총 크기
    var totalDownloadAmount: Double = 0
    var session: URLSession!
    var buffer: Data?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureHierarchy() {
        view.addSubview(imageView)
        view.addSubview(progressView)
        view.addSubview(requestButton)
    }
    
    override func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(400)
        }
        progressView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.height.equalTo(3)
        }
        
        requestButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.equalTo(progressView.snp.bottom).offset(20)
        }
        
    }
    
    override func configureView() {
        progressView.trackTintColor = .lightGray
        progressView.progressTintColor = .systemMint
        progressView.progress = 0.0
        
        var btnConfiguration = UIButton.Configuration.filled()
        btnConfiguration.title = "Download"
        btnConfiguration.cornerStyle = .capsule
        btnConfiguration.baseBackgroundColor = .systemMint
        requestButton.configuration = btnConfiguration
        requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
        
        imageView.backgroundColor = .gray
    }
    
    @objc func requestButtonTapped() {
        print(#function)
        buffer = Data()
        callRequest()
        requestButton.isEnabled = false
    }
    
    func callRequest() {
        
        let request = URLRequest(url: Nasa.photo)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: request).resume()
        print(#function)
    }
}

extension NasaUrlSessionVC: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(#function, response)
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
        
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!

            totalDownloadAmount = Double(contentLength)!
            return.allow
        } else {
            return .cancel
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(#function, data)
        buffer?.append(data)
        let result = Double(buffer?.count ?? 0) / totalDownloadAmount
        progressView.progress = Float(result)
    }
    
    // 응답이 완료될 때 호출됨
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            let alert = UIAlertController(
                title: "에러발생",
                message: "잠시 후 다시 시도해주세요.",
                preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            present(alert, animated: true)
            
        } else {
            print("성공") // completionHandler 시점과 동일
            requestButton.isEnabled = true
            guard let buffer = buffer else {
                imageView.image = UIImage(systemName: "heart")
                return
            }
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
}


