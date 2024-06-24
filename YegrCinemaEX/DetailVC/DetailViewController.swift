//
//  DetailViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let subposterImageView = UIImageView()
    let detailTableView = UITableView()
    
    var selectedMovie: MovieData.Results?
    var castData: [CreditData.Cast] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureLayout()
        setViewData()
        configureTableView()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "출연/제작"
    }
    
    func configureTableView() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(DetailOverViewTableViewCell.self, forCellReuseIdentifier: DetailOverViewTableViewCell.id)
        detailTableView.register(DetailCastTableViewCell.self, forCellReuseIdentifier: DetailCastTableViewCell.id)
    }
    
    func configureLayout() {
        // configureHierarchy
        view.addSubview(posterImageView)
        view.addSubview(detailTableView)
        posterImageView.addSubview(titleLabel)
        posterImageView.addSubview(subposterImageView)
        
        // configureLayout
        let safeArea = view.safeAreaLayoutGuide
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(220)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(15)
            $0.horizontalEdges.equalTo(posterImageView).inset(15)
            $0.height.equalTo(30)
        }
        
        subposterImageView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(posterImageView.snp.leading).offset(15)
            $0.width.equalTo(100)
            $0.bottom.equalTo(posterImageView.snp.bottom).offset(-10)
        }
        
        detailTableView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(view)
        }
        
        // configureUI
        posterImageView.contentMode = .scaleAspectFill
        subposterImageView.contentMode = .scaleAspectFill
        titleLabel.setUI(aligment: .left, lbTextColor: .white, fontStyle: .systemFont(ofSize: 24, weight: .black))
        titleLabel.numberOfLines = 0
    }
    
    func setViewData() {
        guard let selectedMovie = selectedMovie else { return }
        let backImage = selectedMovie.backdropPath
        let posterImage = selectedMovie.posterPath
        let backImageURL = URL(string: "https://image.tmdb.org/t/p/w500\(backImage)")
        let posterImageURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterImage)")
        
        posterImageView.kf.setImage(with: backImageURL)
        titleLabel.text = selectedMovie.title
        subposterImageView.kf.setImage(with: posterImageURL)
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "OverView"
        } else {
            return "Casts"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let overViewCell = tableView.dequeueReusableCell(withIdentifier: DetailOverViewTableViewCell.id, for: indexPath) as? DetailOverViewTableViewCell else { return UITableViewCell() }
            overViewCell.selectionStyle = .none
            overViewCell.tableVew = detailTableView
            if let selectedMovie = selectedMovie {
                overViewCell.configureCell(overViewData: selectedMovie)
            }
            return overViewCell
        } else {
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: DetailCastTableViewCell.id, for: indexPath) as? DetailCastTableViewCell else { return UITableViewCell() }
            castCell.selectionStyle = .none
            castCell.index = indexPath.row
            castCell.configureCell(castData: castData)
            return castCell
        }
    }
}
