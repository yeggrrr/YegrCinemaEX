//
//  RecommendTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import UIKit
import SnapKit

class RecommendTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let recommendCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var recommendResults: [ContentsImageData.ContentsResults] = []
    
    var cellType: CellType = .none
    
    enum CellType {
        case exist
        case none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureData(recommendResults: [ContentsImageData.ContentsResults]) {
        if recommendResults.isEmpty {
            self.cellType = .none
        } else {
            self.recommendResults = recommendResults
            self.cellType = .exist
        }
        
        recommendCollectionView.reloadData()
    }
    
    func configureUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(recommendCollectionView)
        
        let safeArea = contentView.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalTo(safeArea).offset(10)
            $0.height.equalTo(20)
        }
        
        recommendCollectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalTo(safeArea).inset(5)
            $0.bottom.equalTo(safeArea).offset(-5)
        }
        
        titleLabel.text = "추천 영화"
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    func configureCollectionView() {
        recommendCollectionView.dataSource = self
        recommendCollectionView.delegate = self
        recommendCollectionView.register(RecommendCollectionViewCell.self, forCellWithReuseIdentifier: RecommendCollectionViewCell.id)
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout  = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 5
        let cellSpacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 2)
        layout.itemSize = CGSize(width: width / 3, height: width / 1.5)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: 0, bottom: sectionSpacing, right: 0)
        return layout
    }
}

extension RecommendTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch cellType {
        case .exist:
            return recommendResults.count
        case .none:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCollectionViewCell.id, for: indexPath) as? RecommendCollectionViewCell else { return UICollectionViewCell() }
        cell.posterImageView.contentMode = .scaleAspectFill
        cell.posterImageView.clipsToBounds = true
        
        switch cellType {
        case .exist:
            guard let posterPath = recommendResults[indexPath.row].posterPath else { return UICollectionViewCell() }
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
            cell.posterImageView.kf.setImage(with: url)
        case .none:
            cell.posterImageView.image = UIImage(named: "no_recommend")
        }
        
        return cell
    }
}
