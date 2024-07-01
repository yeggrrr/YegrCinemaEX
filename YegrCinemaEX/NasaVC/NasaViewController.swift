//
//  NasaViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import UIKit
import SnapKit

class NasaViewController: UIViewController {
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
    
    let nasaImageView = UIImageView()
    let progressLabel = UILabel()
    let requestButton = UIButton()
    
    var session: URLSession?
    var total: Double = 0
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(String(format: "%.1f", result * 100)) / 100"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressLabel)
        view.addSubview(requestButton)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        requestButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.top.equalTo(requestButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(safeArea).inset(20)
            $0.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        title = "NASA"
        
        requestButton.setTitle("클릭", for: .normal)
        requestButton.setTitleColor(.white, for: .highlighted)
        requestButton.setTitleColor(.black, for: .normal)
        requestButton.backgroundColor = .systemGray5
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
        
        progressLabel.backgroundColor = .lightGray
        
        nasaImageView.backgroundColor = .systemGray6
    }
    
    func callRequest() {
        let request = URLRequest(url: Nasa.photo)
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session?.dataTask(with: request).resume()
    }
    
    @objc func requestButtonClicked() {
        buffer = Data()
        callRequest()
    }
}

extension NasaViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            if let contentLength = response.value(forHTTPHeaderField: "Content-Length") {
                if let stringToDoubleLength = Double(contentLength) {
                    total = stringToDoubleLength
                    return .allow
                }
            }
        }
        
        return .cancel
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            progressLabel.text = "문제가 발생했습니다."
        } else {
            print("SUCCESS")
            guard let buffer = buffer else {
                print("Buffer nil")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
}
