//
//  RelatedContentsCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import UIKit
import SnapKit

class RelatedContentsCollectionViewCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        posterImageView.backgroundColor = .darkGray
    }
}
