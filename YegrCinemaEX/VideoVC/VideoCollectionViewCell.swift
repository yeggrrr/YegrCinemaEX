//
//  VideoCollectionViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import UIKit
import SnapKit

final class VideoCollectionViewCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let posterImageView = UIImageView()
    private let overviewScrollView = UIScrollView()
    private let overviewBackgroundView = UIView()
    private let overviewLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterImageView)
        contentView.addSubview(overviewScrollView)
        overviewScrollView.addSubview(overviewBackgroundView)
        overviewBackgroundView.addSubview(overviewLabel)
    }
    
    private func configureLayout() {
        let safeArea = contentView.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(30)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(60)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.height.equalTo(380)
        }
        
        overviewScrollView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
            $0.bottom.equalTo(safeArea).offset(-30)
        }
        
        let scrollViewFrame = overviewScrollView.frameLayoutGuide
        let scrollViewContent = overviewScrollView.contentLayoutGuide
        
        overviewBackgroundView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollViewContent.snp.verticalEdges)
            $0.horizontalEdges.equalTo(scrollViewFrame.snp.horizontalEdges)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.edges.equalTo(overviewBackgroundView.snp.edges).inset(10)
        }
    }
    
    private func configureUI() {
        titleLabel.videoUI(txtColor: .label, txtAlignment: .center, fontStyle: .systemFont(ofSize: 22, weight: .bold), titleNumberOfLines: 0)
        overviewLabel.videoUI(txtColor: .white, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .regular), titleNumberOfLines: 0)
        overviewBackgroundView.backgroundColor = .lightGray
        overviewBackgroundView.layer.cornerRadius = 10
        posterImageView.VideoUI()
    }
    
    func configureCell(seriesData: PopularSeriesList.Results) {
        guard let posterImage = URL(string: seriesData.posterPath) else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        titleLabel.text = seriesData.name
        posterImageView.kf.setImage(with: imageURL)
        if seriesData.overview == "" {
            overviewLabel.text = "No overview information"
            overviewLabel.textAlignment = .center
        } else {
            overviewLabel.text = seriesData.overview
        }
    }
}
