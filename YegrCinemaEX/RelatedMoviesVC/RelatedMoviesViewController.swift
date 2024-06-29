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
    
    var similarDataList: [ContentsImageData.ContentsResults] = [] {
        didSet {
            relatedMoviesTableView.reloadRows(at: [IndexPath(row: CellType.similar.rawValue, section: 0)], with: .automatic)
        }
    }
    var recommendDataList: [ContentsImageData.ContentsResults] = [] {
        didSet {
            relatedMoviesTableView.reloadRows(at: [IndexPath(row: CellType.recommend.rawValue, section: 0)], with: .automatic)
        }
    }
    var posterDataList: [MoviePosterData.Backdrops] = [] {
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
        APICall.shared.getSimilar(api: .similar(id: id)) { similarData in
            self.similarDataList = similarData
        } errorHandler: { error in
            self.showAlert(title: "비슷한 영화 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
        }
        
        APICall.shared.getRecommend(api: .recommend(id: id)) { recommendData in
            self.recommendDataList = recommendData
        } errorHandler: { error in
            self.showAlert(title: "추천 영화 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
        }
        
        APICall.shared.getPosterImage(api: .poster(id: id)) { posterData, error in
            if error != nil {
                self.showAlert(title: "영화 포스터 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
            } else {
                guard let posterData = posterData else { return }
                self.posterDataList = posterData
            }
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
            let similarCell = SimilarTableViewCell()
            similarCell.selectionStyle = .none
            similarCell.configureData(similarResults: similarDataList)
            return similarCell
        case .recommend:
            let recommendCell = RecommendTableViewCell()
            recommendCell.selectionStyle = .none
            recommendCell.configureData(recommendResults: recommendDataList)
            return recommendCell
        case .poster:
            let posterCell = PosterTableViewCell()
            posterCell.selectionStyle = .none
            posterCell.configureData(posterResults: posterDataList)
            posterCell.posterCollectionView.reloadData()
            return posterCell
        }
    }
}
