//
//  RelatedContentsViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import UIKit
import SnapKit
import Kingfisher

enum CellType: String {
    case similar = "비슷한 영화"
    case recommend = "추천 영화"
    case poster = "포스터"
}

final class RelatedContentsViewController: UIViewController {
    private let movieTitleLabel = UILabel()
    private let relatedcontentsTableView = UITableView()
    
    var movieTitle: String?
    var id: Int?
    
    private var contentsImageList: [[ContentsImageData.ContentsResults]] = []
    private var posterImageList: [MoviePosterData.Backdrops] = []
    
    private let cellTypeList: [CellType] = [.similar, .recommend, .poster]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
        configureUI()
        
        if let id = id {
            getData(id: id)
        }
    }
    
    private func configureNavigation() {
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreInfoButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func configureTableView() {
        relatedcontentsTableView.delegate = self
        relatedcontentsTableView.dataSource = self
        relatedcontentsTableView.register(RelatedContentsTableViewCell.self, forCellReuseIdentifier: RelatedContentsTableViewCell.id)
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(movieTitleLabel)
        view.addSubview(relatedcontentsTableView)
        
        let safeArea = view.safeAreaLayoutGuide
        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(10)
            $0.leading.equalTo(safeArea).offset(10)
            $0.height.equalTo(30)
        }
        
        relatedcontentsTableView.snp.makeConstraints {
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
        
        relatedcontentsTableView.backgroundColor = .lightGray
    }
    
    private func getData(id: Int) {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getSimilar(api: .similar(id: id)) { results in
                self.contentsImageList.append(results)
                group.leave()
            } errorHandler: { error in
                self.showAlert(title: "비슷한 영화 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getRecommend(api: .recommend(id: id)) { results in
                self.contentsImageList.append(results)
                group.leave()
            } errorHandler: { error in
                self.showAlert(title: "추천 영화 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getPosterImage(api: .poster(id: id)) { results, error in
                if error != nil {
                    self.showAlert(title: "영화 포스터 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
                } else {
                    guard let results = results else { return }
                    self.posterImageList = results
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.relatedcontentsTableView.reloadData()
        }
    }
    
    @objc func moreInfoButtonClicked() {
        print(#function)
    }
}

extension RelatedContentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch cellTypeList[indexPath.row] {
        case .similar, .recommend:
            return 220
        case .poster:
            return 280
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if posterImageList.isEmpty {
            return contentsImageList.count
        } else {
            return contentsImageList.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedContentsTableViewCell.id, for: indexPath) as?
                RelatedContentsTableViewCell else { return UITableViewCell() }
        let cellType = cellTypeList[indexPath.row]
        switch cellType {
        case .similar, .recommend:
            cell.contentsView.collectionView.delegate = self
            cell.contentsView.collectionView.dataSource = self
            cell.contentsView.collectionView.tag = indexPath.row
        case .poster:
            cell.postersView.collectionView.delegate = self
            cell.postersView.collectionView.dataSource = self
            cell.postersView.collectionView.tag = indexPath.row
        }
        cell.configureCollectionView(cellType: cellType)
        cell.configureTitle(title: cellType.rawValue)
        return cell
    }
}

extension RelatedContentsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellTypeList[collectionView.tag] {
        case .similar, .recommend:
            return contentsImageList[collectionView.tag].count
        case .poster:
            return posterImageList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedContentsCollectionViewCell.id, for: indexPath) as? RelatedContentsCollectionViewCell else { return UICollectionViewCell() }
        switch cellTypeList[collectionView.tag] {
        case .similar, .recommend:
            if let imageData = contentsImageList[collectionView.tag][indexPath.item].posterPath {
                let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageData)")
                cell.posterImageView.kf.setImage(with: posterURL)
            }
        case .poster:
            let imageData = posterImageList[indexPath.item].filePath
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageData)")
            cell.posterImageView.kf.setImage(with: posterURL)
        }
        
        return cell
    }
}
