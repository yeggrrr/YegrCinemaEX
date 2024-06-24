//
//  RelatedMoviesViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import UIKit
import SnapKit

class RelatedMoviesViewController: UIViewController {
    enum CellType: Int {
        case similar = 0
        case recommend = 1
        case poster = 2
    }
    
    let movieTitleLabel = UILabel()
    let relatedMoviesTableView = UITableView()
    let cellTypeList: [CellType] = [.similar, .recommend, .poster]
    
    var movieTitle: String?
    var id: Int?
    var similarDataList: SimilarData? {
        didSet {
            relatedMoviesTableView.reloadRows(at: [IndexPath(row: CellType.similar.rawValue, section: 0)], with: .automatic)
        }
    }
    var recommendDataList: RecommendData? {
        didSet {
            relatedMoviesTableView.reloadRows(at: [IndexPath(row: CellType.recommend.rawValue, section: 0)], with: .automatic)
        }
    }
    var posterDataList: PosterImageData? {
        didSet {
            relatedMoviesTableView.reloadRows(at: [IndexPath(row: CellType.poster.rawValue, section: 0)], with: .automatic)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureUI()
        configureTableView()
        
        if let id = id {
            getData(id: id)
        }
    }
    
    func getData(id: Int) {
        APICall.shared.getSimilarData(id: id) { similarData in
            self.similarDataList = similarData
        }
        
        APICall.shared.getRecommendData(id: id) { recommendData in
            self.recommendDataList = recommendData
        }
        
        APICall.shared.getPosterData(id: id) { posterData in
            self.posterDataList = posterData
        }
    }
    
    func configureNavigation() {
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreInfoButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(movieTitleLabel)
        view.addSubview(relatedMoviesTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(10)
            $0.leading.equalTo(safeArea).offset(10)
            $0.height.equalTo(30)
        }
        
        relatedMoviesTableView.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(view)
        }
        
        if let movieTitle = movieTitle {
            movieTitleLabel.text = movieTitle
        } else {
            movieTitleLabel.text = "선택한 영화 관련 추천"
        }
        
        movieTitleLabel.textColor = .black
        movieTitleLabel.textAlignment = .left
        movieTitleLabel.font = .systemFont(ofSize: 25, weight: .bold)
    }
    
    func configureTableView() {
        relatedMoviesTableView.delegate = self
        relatedMoviesTableView.dataSource = self
        
        relatedMoviesTableView.register(SimilarTableViewCell.self, forCellReuseIdentifier: SimilarTableViewCell.id)
        relatedMoviesTableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.id)
        relatedMoviesTableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
    }

    @objc func moreInfoButtonClicked() {
        print(#function)
    }
}

extension RelatedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypeList[indexPath.row] {
        case .similar, .recommend:
            return 220
        case .poster:
            return 280
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTypeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellTypeList[indexPath.row] {
        case .similar:
            guard let similarDataList = similarDataList else { return UITableViewCell() }
            
            let similarCell = SimilarTableViewCell()
            similarCell.selectionStyle = .none
            similarCell.configureData(similarResults: similarDataList.results)
            return similarCell
        case .recommend:
            guard let recommendDataList = recommendDataList else { return UITableViewCell() }
            
            let recommendCell = RecommendTableViewCell()
            recommendCell.selectionStyle = .none
            recommendCell.configureData(recommendResults: recommendDataList.results)
            return recommendCell
        case .poster:
            guard let posterDataList = posterDataList else { return UITableViewCell() }
            
            let posterCell = PosterTableViewCell()
            posterCell.selectionStyle = .none
            posterCell.configureData(posterResults: posterDataList.backdrops)
            posterCell.posterCollectionView.reloadData()
            return posterCell
        }
    }
}
