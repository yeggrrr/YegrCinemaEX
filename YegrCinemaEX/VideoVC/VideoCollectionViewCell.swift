//
//  VideoCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import UIKit
import SnapKit

class VideoCollectionViewCell: UICollectionViewCell {
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let overviewScrollView = UIScrollView()
    let overviewBackgroundView = UIView()
    let overviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(overviewScrollView)
        overviewScrollView.addSubview(overviewBackgroundView)
        overviewBackgroundView.addSubview(overviewLabel)
    }
    
    func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(40)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(380)
        }
        
        overviewScrollView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.bottom.equalTo(safeArea).offset(-20)
        }
        
        let scrollViewFrame = overviewScrollView.frameLayoutGuide
        let scrollViewContent = overviewScrollView.contentLayoutGuide
        
        overviewBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollViewContent.snp.verticalEdges)
            $0.horizontalEdges.equalTo(scrollViewFrame.snp.horizontalEdges)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.verticalEdges.equalTo(overviewBackgroundView.snp.verticalEdges)
            $0.horizontalEdges.equalTo(overviewBackgroundView.snp.horizontalEdges)
        }
    }
    
    func configureUI() {
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 20
        posterImageView.clipsToBounds = true
        
        overviewLabel.textColor = .label
        overviewLabel.textAlignment = .left
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 17, weight: .bold)
    }
    
    func configureCell(seriesData: PopularSeriesList.Results) {
        guard let posterImage = URL(string: seriesData.posterPath) else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        titleLabel.text = seriesData.name
        posterImageView.kf.setImage(with: imageURL)
        overviewLabel.text = seriesData.overview
    }
}
