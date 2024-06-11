//
//  DetailCastTableViewCell.swift
//  YegrCinemaEX
//
//  Created by YJ on 6/11/24.
//

import UIKit
import SnapKit
import Kingfisher

class DetailCastTableViewCell: UITableViewCell {
    let profileImageView = UIImageView()
    
    let labelStackView = UIStackView()
    let nameLabel = UILabel()
    let characterLabel = UILabel()

    var index: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        backgroundColor = .white
        
        // configureHierarchy
        contentView.addSubview(profileImageView)
        contentView.addSubview(labelStackView)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(characterLabel)
        
        // configureLayout
        let safeArea = contentView.safeAreaLayoutGuide
        profileImageView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea).inset(10)
            $0.leading.equalTo(safeArea).offset(20)
            $0.width.equalTo(60)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeArea).inset(30)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(safeArea).offset(-20)
        }
        
        nameLabel.snp.makeConstraints {
            $0.height.equalTo(30)
        }
        
        characterLabel.snp.makeConstraints {
            $0.height.equalTo(20)
        }
        
        // configureUI
        profileImageView.backgroundColor = .systemGray5
        
        labelStackView.axis = .vertical
        labelStackView.spacing = 5
        labelStackView.alignment = .leading
        
        nameLabel.text = "djdj"
        nameLabel.setUI(aligment: .left, lbTextColor: .label, fontStyle: .boldSystemFont(ofSize: 17))
        
        characterLabel.text = "dsf"
        characterLabel.setUI(aligment: .left, lbTextColor: .darkGray, fontStyle: .systemFont(ofSize: 15))
    }
    
    func configureCell(castData: [CreditData.Cast]) {
        guard let index = index else { return }
        guard let profileImage = castData[index].profilePath else { return }
        let profileURL = URL(string: "https://image.tmdb.org/t/p/w500\(profileImage)")
        profileImageView.kf.setImage(with: profileURL)
        
        nameLabel.text = castData[index].name
        characterLabel.text = castData[index].character
    }
}
