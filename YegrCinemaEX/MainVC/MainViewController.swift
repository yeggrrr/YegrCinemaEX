//
//  MainViewController.swift
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
    var genreList: [GenreData.Genre] = []
    var resultList: [MovieData.Results] = [] {
        didSet {
            let idList = resultList.map { $0.id }
            for id in idList {
                getCreditsData(id: id) { casts in
                    self.castList.append(casts)
                }
            }
        }
    }
    var castList: [String] = [] {
        didSet {
            let allCastFetched = resultList.count == castList.count
            if allCastFetched {
                self.trendTableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureNavigation()
        configureUI()
        getGenreData()
        getMovieData()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.id)
        trendTableView.separatorStyle = .none
        
        view.addSubview(trendTableView)
        trendTableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
    }
    
    func configureNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.topItem?.title = .none
        navigationController?.navigationBar.barTintColor = .white
        
        let left = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = left
        navigationController?.navigationBar.tintColor = UIColor.black
        
        let right = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = right
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func getGenreData() {
        let url = APIURL.genreMovieListURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(url, method: .get, parameters: params, headers: header).responseDecodable(of: GenreData.self) { response in
            switch response.result {
            case .success(let value):
                self.genreList = value.genres
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getMovieData() {
        let url = APIURL.trendingMovieURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization,
            "accept": APIKey.accept
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let value):
                self.resultList = value.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCreditsData(id: Int, completion: @escaping (String) -> Void) {
        let url = "\(APIURL.movieURL)\(id)/credits"
        guard let creditsURL = URL(string: url) else {
            completion("-")
            return
        }
        
        let params: Parameters  =  [
            "api_key": APIKey.apiKey
        ]
        
        AF.request(creditsURL, method: .get, parameters: params).responseDecodable(of: CreditData.self) { response in
            switch response.result {
            case .success(let value):
                let cast = value.cast[0...3]
                    .map{ $0.name }
                    .joined(separator: ", ")
                completion(cast)
            case .failure(let error):
                print(error)
                completion("-")
            }
        }
    }

    func makeGenreText(item: MovieData.Results) -> String {
        guard let genreId = item.genreIds.first else { return "# -" }
        guard let genre = genreList.filter({ $0.id == genreId }).first else { return "# -" }
        return "#\(genre.name)"
    }
    
    func makeScoreText(item: MovieData.Results) -> String {
        let grade = item.voteAverage
        return String(format: "%.1f", grade)
    }
    
    @objc func leftBarButtonClicked() {
        
    }
    
    @objc func rightBarButtonClicked() {
        
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
        let resultData = resultList[indexPath.row]
        let castData = castList[indexPath.row]
        
        cell.backgroundColor = UIColor(named: "cellBackgroundColor")
        cell.selectionStyle = .none
        
        cell.dateLabel.text = DateFormatter.dashToSlash(dateString: resultData.releaseDate)
        cell.genreLabel.text = makeGenreText(item: resultData)
        
        let posterImage = resultData.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        cell.posterImageView.kf.setImage(with: url)
        cell.ScoreNumLabel.text = makeScoreText(item: resultData)
        cell.titleLabel.text = resultData.title
        cell.charactersLabel.text = castData
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.resultData = resultList
        detailVC.index = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
