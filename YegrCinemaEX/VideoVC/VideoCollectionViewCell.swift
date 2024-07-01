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
        titleLabel.videoUI(txtColor: .label, txtAlignment: .center, fontStyle: .systemFont(ofSize: 22, weight: .bold), titleNumberOfLines: 0)
        overviewLabel.videoUI(txtColor: .label, txtAlignment: .left, fontStyle: .systemFont(ofSize: 17, weight: .regular), titleNumberOfLines: 0)
        posterImageView.VideoUI()
    }
    
    func configureCell(seriesData: PopularSeriesList.Results) {
        guard let posterImage = URL(string: seriesData.posterPath) else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        titleLabel.text = seriesData.name
        posterImageView.kf.setImage(with: imageURL)
        if seriesData.overview == "" {
            overviewLabel.text = "No overview information"
        } else {
            overviewLabel.text = seriesData.overview
        }
    }
}
