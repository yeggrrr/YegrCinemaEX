//
//  YouTubeWebViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import UIKit
import WebKit

class YouTubeWebViewController: UIViewController {
    let webView = WKWebView()
    var key: String?
    var series: PopularSeriesList.Results?
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        configureUI()
        configureWebView()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        guard let seriesName = series?.name else { return }
        title = seriesName
    }
    
    func configureWebView() {
        view.addSubview(webView)
        
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        webView.backgroundColor = .systemGray
        
        guard let key = key else { return }
        let youTubeLink = "https://www.youtube.com/watch?v=\(key)"
        guard let youTubeURL = URL(string: youTubeLink) else {
            print("youTubeURL 없음")
            return }
        let request = URLRequest(url: youTubeURL)
        webView.load(request)
    }
}
