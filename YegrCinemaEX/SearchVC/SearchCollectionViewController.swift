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
    
    var movieList: [SearchMovie.Results] = [] {
        didSet {
            searchCollectionView.reloadData()
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureNavigation()
        configureCollectionView()
        configureUI()
        getMovieData(query: "12") { results in
            self.movieList = results
        }
    }
    
    func configureNavigation() {
        navigationItem.title = "영화 검색"
    }
    
    func configureCollectionView() {
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.id)
    }
    
    func configureUI() {
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
            $0.bottom.equalTo(safeArea)
        }
    }
    
    func getMovieData(query: String, completion: @escaping ([SearchMovie.Results]) -> Void) {
        let url = APIURL.searchMovieURL
        let header: HTTPHeaders = [
            "Authorization": APIKey.authorization
        ]
        let param: Parameters = [
            "query": query,
            "language": "ko-KR"
        ]
        
        AF.request(url, method: .get, parameters: param, headers: header).responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                completion(value.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
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
}
