//
//  RecommendCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import UIKit
import SnapKit

class RecommendCollectionViewCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureUI()
    }
    
    func configureUI() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.verticalEdges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 10
    }
}
