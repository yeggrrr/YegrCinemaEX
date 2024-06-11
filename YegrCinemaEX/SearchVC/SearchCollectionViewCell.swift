//
//  SearchCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    let posterStackView = UIStackView()
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    var index: Int?
    
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
            $0.height.equalTo(17)
        }
        
        posterImageView.contentMode = .scaleToFill
        titleLabel.backgroundColor = .darkGray
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
    }
    
    func configureCell(movieData: [SearchMovie.Results]) {
        guard let index = index else { return }
        guard let posterImage = movieData[index].posterPath else { return }
        let posterImageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        
        posterImageView.kf.setImage(with: posterImageURL)
        posterImageView.kf.indicatorType = .activity
        
        titleLabel.text = movieData[index].title
    }
}
