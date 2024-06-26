//
//  SearchDetailViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/26/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchDetailViewController: UIViewController {
    let titleLabel = UILabel()
    let posterImageView = UIImageView()
    let overviewLabel = UILabel()
    
    var searchList: SearchMovie.Results?
    
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
            $0.height.greaterThanOrEqualTo(20)
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
            $0.height.equalTo(400)
        }
        
        overviewLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(35)
            $0.bottom.lessThanOrEqualTo(safeArea).offset(-20)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        
        guard let title = searchList?.title else { return }
        guard let overview = searchList?.overview else { return }
        guard let posterImage = searchList?.posterPath else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        
        titleLabel.detailUI(txt: title, txtAlignment: .center, fontStyle: .systemFont(ofSize: 20, weight: .bold))
        overviewLabel.detailUI(txt: overview, txtAlignment: .left, fontStyle: .systemFont(ofSize: 15, weight: .regular))
        posterImageView.setUI(borderColor: UIColor.darkGray.cgColor)
        posterImageView.kf.setImage(with: imageURL)
    }
}
