//
//  RelatedMoviesViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import UIKit
import SnapKit

class RelatedMoviesViewController: UIViewController {
    let relatedMoviesTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .lightGray
        configureNavigation()
        configureTableView()
    }
    
    func configureNavigation() {
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreInfoButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configureTableView() {
        relatedMoviesTableView.delegate = self
        relatedMoviesTableView.dataSource = self
        
        relatedMoviesTableView.register(SimilarTableViewCell.self, forCellReuseIdentifier: SimilarTableViewCell.id)
        relatedMoviesTableView.register(RecommendTableViewCell.self, forCellReuseIdentifier: RecommendTableViewCell.id)
        relatedMoviesTableView.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        
        view.addSubview(relatedMoviesTableView)
        relatedMoviesTableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
    }

    @objc func moreInfoButtonClicked() {
        print(#function)
    }
}

extension RelatedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 220
        } else if indexPath.row == 1 {
            return 220
        } else {
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let similarCell = tableView.dequeueReusableCell(withIdentifier: SimilarTableViewCell.id, for: indexPath) as? SimilarTableViewCell else { return UITableViewCell() }
            similarCell.selectionStyle = .none
            return similarCell
        } else if indexPath.row == 1 {
            guard let recommendCell = tableView.dequeueReusableCell(withIdentifier: RecommendTableViewCell.id, for: indexPath) as? RecommendTableViewCell else { return UITableViewCell() }
            recommendCell.selectionStyle = .none
            return recommendCell
        } else {
            guard let posterCell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as? PosterTableViewCell else { return UITableViewCell() }
            posterCell.selectionStyle = .none
            return posterCell
        }
    }
}
