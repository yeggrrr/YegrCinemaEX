//
//  ViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/10/24.
//

import UIKit
import SnapKit

class TrendViewController: UIViewController {
    let trendTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureTableVeiw()
        configureNavigation()
        configurHierarchy()
        configureLayout()
        configureUI()
    }
    
    func configureTableVeiw() {
        trendTableView.delegate = self
        trendTableView.dataSource = self
        trendTableView.register(TrendTableViewCell.self, forCellReuseIdentifier: TrendTableViewCell.id)
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.topItem?.title = "Trend"
        navigationController?.navigationBar.barTintColor = .white
        
        let left = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(leftBarButtonClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = left
        navigationController?.navigationBar.tintColor = UIColor.black
        
        let right = UIBarButtonItem(image: UIImage(named: "magnifyingglass"), style: .plain, target: self, action: #selector(rightBarButtonClicked))
        navigationController?.navigationBar.topItem?.rightBarButtonItem = right
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    func configurHierarchy() {
        view.addSubview(trendTableView)
    }
    
    func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        trendTableView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
    }
    
    @objc func leftBarButtonClicked() {
        
    }
    
    @objc func rightBarButtonClicked() {
        print("d")
    }
}

extension TrendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrendTableViewCell.id, for: indexPath) as? TrendTableViewCell else { return UITableViewCell() }
        return cell
    }
}
