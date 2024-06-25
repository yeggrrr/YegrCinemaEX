//
//  RelatedContentsViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import UIKit
import SnapKit
import Kingfisher

class RelatedContentsViewController: UIViewController {
    
    let movieTitleLabel = UILabel()
    let relatedcontentsTableView = UITableView()
    
    var movieTitle: String?
    var id: Int?
    
    var contentsImageList: [[ContentsImageData.ContentsResults]] = [
        [ContentsImageData.ContentsResults(posterPath: "")],
        [ContentsImageData.ContentsResults(posterPath: "")]
    ]
    
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
                self.contentsImageList[0] = results
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APICall.shared.getRecommend(id: id) { results in
                self.contentsImageList[1] = results
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
        return 220
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsImageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedContentsTableViewCell.id, for: indexPath) as?
                RelatedContentsTableViewCell else { return UITableViewCell() }
        
        cell.posterCollectionView.delegate = self
        cell.posterCollectionView.dataSource = self
        cell.posterCollectionView.register(RelatedContentsCollectionViewCell.self, forCellWithReuseIdentifier: RelatedContentsCollectionViewCell.id)
        
        cell.posterCollectionView.tag = indexPath.row
        cell.posterCollectionView.reloadData()
        return cell
    }
}

extension RelatedContentsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentsImageList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelatedContentsCollectionViewCell.id, for: indexPath) as? RelatedContentsCollectionViewCell else { return UICollectionViewCell() }
        
        if let imageData = contentsImageList[collectionView.tag][indexPath.item].posterPath {
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageData)")
            cell.posterImageView.kf.setImage(with: posterURL)
        }
        
        return cell
    }
}
