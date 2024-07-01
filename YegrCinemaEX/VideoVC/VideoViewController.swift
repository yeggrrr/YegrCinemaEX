//
//  VideoViewController.swift
//  YegrCinemaEX
//
//  Created by YJ on 7/1/24.
//

import UIKit
import SnapKit

class VideoViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    var seriesList: [PopularSeriesList.Results] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        callRequest()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        title = "비디오"
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.id)
        collectionView.isPagingEnabled = true
    }
    
    func callRequest() {
        APICall.shared.callRequest(api: .popularSeries, model: PopularSeriesList.self) { seriesData in
            guard let seriesData = seriesData else { return }
            self.seriesList.append(contentsOf: seriesData.results)
            print(self.seriesList)
        } errorHandler: { error in
            print(error)
        }
    }
    
    static func collectionViewLayout() -> UICollectionViewLayout {
        let layout  = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 10
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
        print(#function)
    }
}
