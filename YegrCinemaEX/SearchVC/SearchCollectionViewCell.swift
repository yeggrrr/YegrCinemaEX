//
//  SearchCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    let posterStackView = UIStackView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureUI() {
        backgroundColor = .systemGray6
        
        contentView.addSubview(posterStackView)
        posterStackView.addSubview(posterImageView)
        posterStackView.addSubview(titleLabel)
        
        let safeArea = contentView.safeAreaLayoutGuide
        
        posterStackView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(posterStackView)
            $0.horizontalEdges.equalTo(posterStackView)
            $0.bottom.equalTo(titleLabel.snp.top)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(posterStackView)
            $0.bottom.equalTo(posterStackView)
            $0.height.equalTo(20)
        }
        
        posterImageView.backgroundColor = .systemGray4
        titleLabel.backgroundColor = .systemGray3
    }
}
