//
//  RelatedContentsTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import UIKit
import SnapKit

class RelatedContentsTableViewCell: UITableViewCell {
    let titleLabel = UILabel()
    let contentsView = ContentsView()
    let postersView = PostersView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCollectionView(cellType: CellType) {
        switch cellType {
        case .similar, .recommend:
            postersView.isHidden = true
            contentsView.collectionView.register(RelatedContentsCollectionViewCell.self, forCellWithReuseIdentifier: RelatedContentsCollectionViewCell.id)
            contentsView.collectionView.reloadData()
        case .poster:
            contentsView.isHidden = true
            postersView.collectionView.register(RelatedContentsCollectionViewCell.self, forCellWithReuseIdentifier: RelatedContentsCollectionViewCell.id)
            postersView.collectionView.reloadData()
        }
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(contentsView)
        contentView.addSubview(postersView)
    }
    
    func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(5)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
            $0.height.equalTo(20)
        }
        
        contentsView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
            $0.bottom.equalTo(safeArea)
        }
        
        postersView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(5)
            $0.bottom.equalTo(safeArea)
        }
    }
    
    func configureTitle(title: String) {
        titleLabel.text = title
    }
    
    func configureView() {
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
    }
}
