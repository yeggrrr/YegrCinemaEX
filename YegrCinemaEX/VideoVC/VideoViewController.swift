//
//  VideoViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import UIKit
import SnapKit

final class VideoViewController: UIViewController {
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private var seriesList: [PopularSeriesList.Results] = [] {
        didSet {
            let idList = seriesList.map { $0.id }
            
            for id in idList {
                APICall.shared.callRequest(api: .videos(id: id), model: YouTubeLinkKey.self) { keyResults in
                    if let keyResults = keyResults, !keyResults.results.isEmpty {
                        self.keyList.append(keyResults.results[0].key)
                    } else {
                        self.keyList.append(nil)
                    }
                } errorHandler: { error in
                    print(error)
                }
            }
            
            collectionView.reloadData()
        }
    }
    
    private var keyList: [String?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        callRequest()
    }
    
    private func configureUI() {
        view.backgroundColor = .lightGray
        
        title = "비디오"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.id)
        collectionView.isPagingEnabled = true
        collectionView.layer.cornerRadius = 20
    }
    
    private func callRequest() {
        APICall.shared.callRequest(api: .popularSeries, model: PopularSeriesList.self) { seriesData in
            guard let seriesData = seriesData else { return }
            self.seriesList.append(contentsOf: seriesData.results)
        } errorHandler: { error in
            print(error)
        }
    }
    
    private static func collectionViewLayout() -> UICollectionViewLayout {
        let layout  = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 5
        let cellSpacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 2)
        layout.itemSize = CGSize(width: width, height: width * 2)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = .zero
        layout.minimumInteritemSpacing = .zero
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: 0, bottom: sectionSpacing, right: 0)
        return layout
    }
}

extension VideoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seriesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.id, for: indexPath) as? VideoCollectionViewCell else { return UICollectionViewCell() }
        cell.configureCell(seriesData: seriesList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if keyList[indexPath.item] != nil {
            let vc = YouTubeWebViewController()
            vc.series = seriesList[indexPath.item]
            vc.key = keyList[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert(title: "해당 영상이 준비되어 있지 않습니다.")
        }
    }
}
