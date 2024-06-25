//
//  ContentsView.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/26/24.
//

import UIKit
import SnapKit

class ContentsView: UIView {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: contentsCollectionViewLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
     static func contentsCollectionViewLayout() -> UICollectionViewLayout {
         let layout = UICollectionViewFlowLayout()
         layout.itemSize = CGSize(width: 120, height: 180)
         layout.minimumLineSpacing = 5
         layout.minimumInteritemSpacing = 0
         layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
         layout.scrollDirection = .horizontal
         return layout
     }
}


