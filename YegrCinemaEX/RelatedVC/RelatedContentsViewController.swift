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

class RelatedContentsViewController: UIViewController {
    let movieTitleLabel = UILabel()
    let relatedcontentsTableView = UITableView()
    
    var movieTitle: String?
    var id: Int?
    
    var contentsImageList: [[ContentsImageData.ContentsResults]] = []
    var posterImageList: [MoviePosterData.Backdrops] = []
    
    let cellTypeList: [CellType] = [.similar, .recommend, .poster]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureTableView()
        configureUI()
        
        if let id = id {
            getData(id: id)
        }
    }
    
    func configureNavigation() {
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreInfoButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configureTableView() {
        relatedcontentsTableView.delegate = self
        relatedcontentsTableView.dataSource = self
        relatedcontentsTableView.register(RelatedContentsTableViewCell.self, forCellReuseIdentifier: RelatedContentsTableViewCell.id)
    }
    
    func configureUI() {
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
    
    func getData(id: Int) {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getSimilar(id: id) { results in
                self.contentsImageList.append(results)
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getRecommend(id: id) { results in
                self.contentsImageList.append(results)
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getPosterImage(id: id) { results in
                self.posterImageList = results
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
