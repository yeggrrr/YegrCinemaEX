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
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(30)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(400)
        }
        
        overviewScrollView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
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
        titleLabel.text = "제목"
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        posterImageView.backgroundColor = .systemGray6
        
        overviewLabel.text = "fskhfaksfhakjhfskhfaksfhakjhfskhfaksfhakjhfskhfaksfhakjhfskhfaksfhakjhfskhfaksfhakjh"
        overviewLabel.textColor = .label
        overviewLabel.textAlignment = .left
        overviewLabel.numberOfLines = 0
        overviewLabel.font = .systemFont(ofSize: 17, weight: .bold)
        
    }
}
