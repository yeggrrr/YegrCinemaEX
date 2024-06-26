//
//  SearchDetailViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/26/24.
//

import UIKit
import SnapKit

class SearchDetailViewController: UIViewController {
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let overviewLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(posterImageView)
        view.addSubview(overviewLabel)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(30)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.height.equalTo(30)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
            $0.height.equalTo(400)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(35)
            $0.bottom.greaterThanOrEqualTo(safeArea).offset(-30)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        titleLabel.text = "영화제목"
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        posterImageView.backgroundColor = .systemGray5
        posterImageView.layer.cornerRadius = 10
        posterImageView.layer.borderWidth = 3
        posterImageView.layer.borderColor = UIColor.darkGray.cgColor
        
        overviewLabel.text = "fssfaskjhfdskfhakhdjfhakhfdjhak"
        overviewLabel.textColor = .label
        overviewLabel.textAlignment = .left
        overviewLabel.font = .systemFont(ofSize: 17, weight: .regular)
    }
}
