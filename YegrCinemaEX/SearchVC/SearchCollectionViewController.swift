//
//  SearchCollectionViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

final class SearchCollectionViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private let noticeLabel = UILabel()
    private var page = 1
    private var lastPage: Int?
    
    private var movieList: [SearchMovie.Results] = [] {
        didSet {
            searchCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureUI()
    }
    
    private func configureUI() {
        navigationItem.title = "영화 검색"
        view.backgroundColor = .white
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.prefetchDataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        
        searchBar.delegate = self
        searchBar.placeholder = "영화 제목을 입력하세요"
        
        noticeLabel.textAlignment = .center
        noticeLabel.textColor = .label
        noticeLabel.font = .systemFont(ofSize: 17, weight: .bold)
        noticeLabel.isHidden = true
    }
    
    private func configureLayout() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
        view.addSubview(noticeLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
        }
        
        searchCollectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(view)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.center.equalTo(searchCollectionView.snp.center)
        }
    }
    
    private func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    private static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width:  width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
        
        searchCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        page = 1
        movieList.removeAll()
        guard let searchText = searchBar.text else { return }
        APICall.shared.callRequest(api: .search(query: searchText, page: 1), model: SearchMovie.self) { searchData in
            guard let searchData = searchData else {
                print("CallsearchData Error", #function)
                return }
            self.lastPage = searchData.totalPages
            if self.page == 1 {
                self.movieList = searchData.results
            } else {
                self.movieList.append(contentsOf: searchData.results)
            }
            
            if self.movieList.isEmpty {
                self.noticeLabel.isHidden = false
                self.noticeLabel.text = "검색 결과 없음"
            } else {
                self.noticeLabel.isHidden = true
            }
            self.searchCollectionView.reloadData()
        } errorHandler: { _ in
            self.showAlert(title: "영화 검색 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
        }

        
    }
}

extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.id, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        cell.index = indexPath.item
        cell.configureCell(movieData: movieList)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchDetailVC = SearchDetailViewController()
        searchDetailVC.searchList = movieList[indexPath.item]
        present(searchDetailVC, animated: true)
    }
}

extension SearchCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let lastPage = lastPage else { return }
        for indexPath in indexPaths {
            if lastPage != page {
                if 20 * (page - 1) < indexPath.item {
                    page += 1
                    guard let text = searchBar.text else { return }
                    APICall.shared.callRequest(api: .search(query: text, page: page), model: SearchMovie.self) { movieData in
                        guard let movieData = movieData else {
                            print("callMovieData Error", #function)
                            return }
                        self.movieList.append(contentsOf: movieData.results)
                    } errorHandler: { _ in
                        self.showAlert(title: "영화 검색 정보를 가져오지 못했습니다. 잠시 후 다시 시도해주세요.")
                    }

                }
            }
        }
    }
}
