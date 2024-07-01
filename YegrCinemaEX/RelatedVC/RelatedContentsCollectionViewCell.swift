//
//  RelatedContentsCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/25/24.
//

import UIKit
import SnapKit

final class RelatedContentsCollectionViewCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentView.addSubview(posterImageView)
        posterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.masksToBounds = true
    }
}
