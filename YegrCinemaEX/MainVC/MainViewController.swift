//
//  ViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/10/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class MainViewController: UIViewController {
    let trendTableView = UITableView()
    var resultList: [Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureNavigation()
        configureUI()
        getMovieData()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        
        view.addSubview(trendTableView)
        trendTableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.topItem?.title = "Trend"
        navigationController?.navigationBar.barTintColor = .white
        
        let left = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = left
        navigationController?.navigationBar.tintColor = UIColor.black
        
        let right = UIBarButtonItem(image: UIImage(named: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = right
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func getMovieData() {
        let url = APIURL.trendURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let value):
                // print(value)
                self.resultList = value.results
                print(self.resultList)
                self.trendTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func leftBarButtonClicked() {
        
    }
    
    @objc func rightBarButtonClicked() {
        print("d")
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.id, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.backgroundColor = UIColor(named: "cellBackgroundColor")
        cell.selectionStyle = .none
        let resultData = resultList[indexPath.row]
        
        let posterImage = resultData.poster_path
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        cell.posterImageView.kf.setImage(with: url)
        
        cell.dateLabel.text = resultData.release_date
        cell.titleLabel.text = resultData.title
        
        let grade = resultData.vote_average
        let formattedGrade = String(format: "%.1f", grade)
        cell.gradeNumLabel.text = formattedGrade
        
        return cell
    }
}
