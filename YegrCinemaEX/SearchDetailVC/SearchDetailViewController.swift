//
//  SearchDetailViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/26/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SearchDetailViewController: UIViewController {
    let searchDetailView = SearchDetailView()
    var searchList: SearchMovie.Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(searchDetailView)
        searchDetailView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
        guard let title = searchList?.title else { return }
        guard let overview = searchList?.overview else { return }
        guard let posterImage = searchList?.posterPath else { return }
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        
        searchDetailView.titleLabel.detailUI(txt: title, txtAlignment: .center, fontStyle: .systemFont(ofSize: 22, weight: .bold))
        searchDetailView.overviewLabel.detailUI(txt: overview, txtAlignment: .left, fontStyle: .systemFont(ofSize: 16, weight: .regular))
        searchDetailView.posterImageView.setUI(borderColor: UIColor.lightGray.cgColor)
        searchDetailView.posterImageView.kf.setImage(with: imageURL)
    }
}
