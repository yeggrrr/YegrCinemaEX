//
//  DetailViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit

class DetailViewController: UIViewController {
    let detailTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureUI()
    }
    
    func configureNavigation() {
        title = "출연/제작"
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    func configureTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.id)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.id, for: indexPath) as? DetailTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
}
