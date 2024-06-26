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

class SearchCollectionViewController: UIViewController {
    let searchBar = UISearchBar()
    let searchCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var page = 1
    var lastPage: Int?
    
    var movieList: [SearchMovie.Results] = [] {
        didSet {
            searchCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureLayout()
    }
    
    func configureUI() {
        navigationItem.title = "영화 검색"
        view.backgroundColor = .white
        
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.prefetchDataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
        
        searchBar.delegate = self
        searchBar.placeholder = "영화 제목을 입력하세요"
    }
    
    func configureLayout() {
        view.addSubview(searchBar)
        view.addSubview(searchCollectionView)
        
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
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 20
        layout.itemSize = CGSize(width:  width / 3, height: width / 3)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }
    
    func getMovieData(query: String, page: Int, completion: @escaping ([SearchMovie.Results]) -> Void) {
        let url = APIURL.searchMovieURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization
        ]
        
        let param: Parameters = [
            "query": query,
            "language": "ko-KR",
            "page": page
        ]
        
        AF.request(url, method: .get, parameters: param, headers: header).responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
                self.lastPage = value.totalPages
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchCollectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        page = 1
        movieList.removeAll()
        guard let text = searchBar.text else { return }
        getMovieData(query: text, page: 1) { results in
            if self.page == 1 {
                self.movieList = results
            } else {
                self.movieList.append(contentsOf: results)
            }
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
        print(movieList[indexPath.row])
        let searchDetailVC = SearchDetailViewController()
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
                    getMovieData(query: text, page: page) { results in
                        self.movieList.append(contentsOf: results)
                    }
                }
            }
        }
    }
}
