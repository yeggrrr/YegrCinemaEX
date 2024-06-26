//
//  DetailOverViewTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit
import SnapKit

final class DetailOverViewTableViewCell: UITableViewCell {
    private let overViewLabel = UILabel()
    private let dropDownButton = UIButton()
    private var buttonState = false
    var tableVew: UITableView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .white
        
        contentView.addSubview(overViewLabel)
        contentView.addSubview(dropDownButton)
        
        let safeArea = contentView.safeAreaLayoutGuide
        overViewLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(20)
            $0.bottom.equalTo(dropDownButton.snp.top).offset(-10)
        }
        
        dropDownButton.snp.makeConstraints {
            $0.top.equalTo(overViewLabel.snp.bottom)
            $0.centerX.equalTo(safeArea)
            $0.height.equalTo(30)
            $0.bottom.equalTo(safeArea)
        }
        
        overViewLabel.setUI(aligment: .left, lbTextColor: .label, fontStyle: .systemFont(ofSize: 15))
        overViewLabel.numberOfLines = 2
        dropDownButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        dropDownButton.tintColor = .black
        dropDownButton.addTarget(self, action: #selector(dropDownButtonClicked), for: .touchUpInside)
    }
    
    func configureCell(overViewData: MovieData.Results) {
        overViewLabel.text = overViewData.overview
    }
    
    @objc func dropDownButtonClicked() {
        buttonState.toggle()
        
        if buttonState {
            overViewLabel.numberOfLines = 0
        } else {
            overViewLabel.numberOfLines = 2
        }
        
        tableVew?.reloadData()
    }
}
