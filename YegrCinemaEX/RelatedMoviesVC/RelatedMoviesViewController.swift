//
//  RelatedMoviesViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/24/24.
//

import UIKit
import SnapKit

class RelatedMoviesViewController: UIViewController {
    let recommendTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureNavigation()
        configureTableView()
    }
    
    func configureNavigation() {
        let right = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(moreInfoButtonClicked))
        navigationItem.rightBarButtonItem = right
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func configureTableView() {
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        recommendTableView.register(SimilarTableViewCell.self, forCellReuseIdentifier: SimilarTableViewCell.id)
        
        view.addSubview(recommendTableView)
        recommendTableView.snp.makeConstraints {
            $0.edges.equalTo(view)
        }
        
    }

    @objc func moreInfoButtonClicked() {
        print(#function)
    }
}

extension RelatedMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SimilarTableViewCell.id, for: indexPath) as? SimilarTableViewCell else { return UITableViewCell() }
        return cell
    }
}
