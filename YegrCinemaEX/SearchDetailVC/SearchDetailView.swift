//
//  SearchDetailView.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/27/24.
//

import UIKit

class SearchDetailView: UIView {
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
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(overviewScrollView)
        overviewScrollView.addSubview(overviewBackgroundView)
        overviewBackgroundView.addSubview(overviewLabel)
    }
    
    func configureLayout() {
        let safeArea = safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(30)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.greaterThanOrEqualTo(20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
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
        backgroundColor = .darkGray
    }
}
