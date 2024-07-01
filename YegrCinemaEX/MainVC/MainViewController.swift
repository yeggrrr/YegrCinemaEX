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
                APICall.shared.callRequest(api: .credits(id: id), model: CreditData.self) { creditData in
                    if let creditData = creditData {
                        self.castData.append(creditData.cast)
                    }
                } errorHandler: { _ in
                    self.showAlert(title: "cast 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
                }
            }
        }
    }
    
    var castData: [[CreditData.Cast]] = [] {
        didSet {
            let allCastFetched = resultList.count == castData.count
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
        APICall.shared.callRequest(api: .genre, model: GenreData.self) { genreData in
            guard let genreData = genreData else {
                print("CallgenreData Error", #function)
                return }
            self.genreList = genreData.genres
        } errorHandler: { _ in
            self.showAlert(title: "영화 장르 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
        }
    }
    
    func getMovieData() {
        APICall.shared.callRequest(api: .movies, model: MovieData.self) { movieData in
            guard let movieData = movieData else {
                print("CallMovieData Error", #function)
                return }
            self.resultList = movieData.results
        } errorHandler: { _ in
            self.showAlert(title: "영화 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
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
    
    func makeCastText(cast: [CreditData.Cast]) -> String {
        let casts = cast[0...3]
            .map{ $0.name }
            .joined(separator: ", ")
        return casts
    }
    
    @objc func leftBarButtonClicked() {
        let videoVC = VideoViewController()
        navigationController?.pushViewController(videoVC, animated: true)
    }
    
    @objc func rightBarButtonClicked() {
        let searchVC = SearchCollectionViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @objc func clipButtonClicked(_ sender: UIButton) {
        // let relatedMoviesVC = RelatedMoviesViewController() // 1
        let relatedVC = RelatedContentsViewController() // 2
        let item = resultList[sender.tag]
        relatedVC.movieTitle = item.title
        relatedVC.id = item.id
        navigationController?.pushViewController(relatedVC, animated: true)
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
        let castData = castData[indexPath.row]
        
        cell.backgroundColor = UIColor(named: "cellBackgroundColor")
        cell.selectionStyle = .none
        
        cell.dateLabel.text = DateFormatter.dashToSlash(dateString: resultData.releaseDate)
        cell.genreLabel.text = makeGenreText(item: resultData)
        
        let posterImage = resultData.posterPath
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        cell.posterImageView.kf.setImage(with: url)
        cell.ScoreNumLabel.text = makeScoreText(item: resultData)
        cell.titleLabel.text = resultData.title
        cell.charactersLabel.text = makeCastText(cast: castData)
        
        cell.clipButton.tag = indexPath.row
        cell.clipButton.addTarget(self, action: #selector(clipButtonClicked), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.selectedMovie = resultList[indexPath.row]
        let casts = castData[indexPath.row]
        detailVC.castData = casts
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
