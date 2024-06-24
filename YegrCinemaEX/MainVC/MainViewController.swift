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
                APICall.shared.getCreditsData(id: id) { creditData in
                    self.castData.append(creditData.cast)
                    let casts = creditData.cast[0...3]
                        .map{ $0.name }
                        .joined(separator: ", ")
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
    
    var castData: [[CreditData.Cast]] = []
    
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
        APICall.shared.getGenreData { genreData in
            self.genreList = genreData.genres
        }
    }
    
    func getMovieData() {
        APICall.shared.getMovieData { movieData in
            self.resultList = movieData.results
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
        print(#function)
    }
    
    @objc func rightBarButtonClicked() {
        let searchVC = SearchCollectionViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func clipButtonClicked() {
        let recommendVC = RelatedMoviesViewController()
        navigationController?.pushViewController(recommendVC, animated: true)
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
        
        cell.clipButton.addTarget(self, action: #selector(clipButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let casts = castData[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.resultData = resultList
        detailVC.castData = casts
        detailVC.index = indexPath.row
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
